#!/usr/bin/env bash
# 스킬이 AGENTS.md의 작성 규약을 지키는지 검사한다
# 규약을 기계적으로 확인할 수 있는 것만 본다. 내용의 質은 사람이 본다
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORD_LIMIT=500

# 본문 상한 예외
# 작업 종류에 따라 읽을 참조 파일이 갈리는 라우팅 스킬만 대상이다
# 규칙이 많다는 것은 예외 사유가 아니다 - 그건 references/로 뺀다
skill_word_limit() {  # $1=스킬 이름
  case "$1" in
    frontend-design) echo 1000 ;;
    *) echo "$WORD_LIMIT" ;;
  esac
}

fail=0
warn=0

report() {  # $1=등급 $2=스킬 $3=메시지
  printf "  %-6s %-18s %s\n" "$1" "$2" "$3"
  [ "$1" = "FAIL" ] && fail=1
  [ "$1" = "WARN" ] && warn=$((warn + 1))
  return 0
}

# frontmatter 값 하나를 뽑는다. 여러 줄 값은 첫 줄만
fm_value() {  # $1=파일 $2=키
  awk -v key="$2" '
    NR == 1 && $0 == "---" { inside = 1; next }
    inside && $0 == "---" { exit }
    inside && index($0, key ": ") == 1 { print substr($0, length(key) + 3); exit }
  ' "$1"
}

echo "→ 스킬 규약 검사"

for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  file="$dir/SKILL.md"

  if [ ! -f "$file" ]; then
    report FAIL "$name" "SKILL.md가 없다"
    continue
  fi

  # frontmatter가 첫 줄부터 시작해야 하네스가 읽는다
  if [ "$(head -1 "$file")" != "---" ]; then
    report FAIL "$name" "frontmatter가 첫 줄에서 시작하지 않는다"
    continue
  fi

  fm_name="$(fm_value "$file" name)"
  fm_desc="$(fm_value "$file" description)"

  [ -n "$fm_name" ] || report FAIL "$name" "name 필드가 없다"
  # 디렉터리 이름과 name이 다르면 호출 이름이 어긋난다
  [ "$fm_name" = "$name" ] || report FAIL "$name" "name이 디렉터리 이름과 다르다 ($fm_name)"

  if [ -z "$fm_desc" ]; then
    report FAIL "$name" "description 필드가 없다"
  else
    # 규약: "<무엇을 한다>. <언제 쓰는지>" 두 부분이어야 한다
    case "$fm_desc" in
      *"사용한다"*|*"쓴다"*) ;;
      *) report WARN "$name" "description에 트리거 절이 안 보인다" ;;
    esac
    # description은 상시 로드된다. 길면 그만큼 매 대화가 무거워진다
    dlen=${#fm_desc}
    [ "$dlen" -le 300 ] || report WARN "$name" "description이 길다 (${dlen}자)"
  fi

  # 허용 필드 외의 키가 있으면 하네스마다 다르게 해석될 수 있다
  extra="$(awk 'NR==1&&$0=="---"{i=1;next} i&&$0=="---"{exit} i&&/^[a-z-]+: /{print $1}' "$file" \
    | tr -d ':' | grep -vE '^(name|description|argument-hint)$' || true)"
  [ -z "$extra" ] || report WARN "$name" "규약 밖 frontmatter 키: $(echo "$extra" | tr '\n' ' ')"

  # 본문 단어 수. frontmatter를 뺀 나머지만 센다
  words="$(awk 'NR==1&&$0=="---"{i=1;next} i&&$0=="---"{i=0;next} !i' "$file" | wc -w | tr -d ' ')"
  limit="$(skill_word_limit "$name")"
  if [ "$words" -gt "$limit" ]; then
    report FAIL "$name" "본문 ${words}단어 (상한 ${limit}). references/로 뺄 것"
  fi

  # @ 임포트는 즉시 강제 로드되어 컨텍스트를 태운다
  if grep -qE '^\s*@[a-zA-Z./]' "$file"; then
    report FAIL "$name" "@ 임포트를 쓰고 있다"
  fi

  # 본문이 가리키는 참조 파일이 실제로 있는지
  while read -r ref; do
    [ -n "$ref" ] || continue
    [ -e "$dir/$ref" ] || report FAIL "$name" "참조 파일이 없다: $ref"
  done < <(grep -oE 'references/[a-zA-Z0-9._-]+\.md' "$file" | sort -u)

  # references/에 있는데 본문에서 아무도 안 부르는 파일
  if [ -d "$dir/references" ]; then
    for ref in "$dir"/references/*.md; do
      [ -e "$ref" ] || continue
      grep -q "references/$(basename "$ref")" "$file" \
        || report WARN "$name" "본문에서 참조되지 않는 파일: references/$(basename "$ref")"
    done
  fi
done

# 서로 다른 스킬이 같은 트리거를 물면 어느 쪽이 뜰지 알 수 없다
echo "→ 스킬 이름 중복"
dupes="$(for d in "$REPO"/skills/*/; do fm_value "$d/SKILL.md" name; done | sort | uniq -d)"
[ -z "$dupes" ] || report FAIL "-" "name 중복: $(echo "$dupes" | tr '\n' ' ')"

# README가 스킬 목록과 어긋나면 사람이 먼저 헷갈린다
echo "→ README 등재"
for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  grep -q "\`$name\`" "$REPO/README.md" || report WARN "$name" "README에 없다"
done

echo
if [ "$fail" -ne 0 ]; then
  echo "FAIL이 있다. 위 항목을 고칠 것."
  exit 1
elif [ "$warn" -ne 0 ]; then
  echo "WARN ${warn}건. 확인해볼 것."
else
  echo "전부 정상."
fi
