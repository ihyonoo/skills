#!/usr/bin/env bash
# 스킬과 전역 지침을 각 하네스 디렉터리에 심볼릭 링크로 연결한다
# 이미 있는 심볼릭 링크는 갱신, 심볼릭 링크가 아닌 항목은 건드리지 않는다
# --check: 링크를 만들지 않고 현재 상태만 검증한다
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECK_ONLY=0
[ "${1:-}" = "--check" ] && CHECK_ONLY=1

# 하네스 스킬 디렉터리
SKILL_DESTS=("$HOME/.claude/skills" "$HOME/.codex/skills")
# 전역 지침: "링크 경로" 형식. 하네스마다 파일명이 다르다
GUIDE_SRC="$REPO/global-instructions.md"
GUIDE_DESTS=("$HOME/.claude/CLAUDE.md" "$HOME/.codex/AGENTS.md")

fail=0

link_one() {  # $1=원본 $2=링크경로
  # 원본 경로의 후행 슬래시를 떼어 readlink 결과와 그대로 비교할 수 있게 한다
  local src="${1%/}" dst="$2" name; name="$(basename "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  skip  $name (심볼릭 링크가 아닌 항목이 이미 있음)"
    # 쓰기 모드에서는 남의 파일을 건드리지 않지만, 검증 모드에서는 미설치이므로 실패다
    if [ "$CHECK_ONLY" -eq 1 ]; then fail=1; fi
    return
  fi
  [ "$CHECK_ONLY" -eq 1 ] || ln -sfn "$src" "$dst"
  # 존재만 보면 엉뚱한 대상을 가리키는 링크도 통과하므로 대상까지 비교한다
  if [ -e "$dst" ] && [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
    echo "  ok    $name"
  else
    echo "  BROKEN $name → $(readlink "$dst" 2>/dev/null)"
    fail=1
  fi
}

# 스킬
for dest in "${SKILL_DESTS[@]}"; do
  if [ ! -d "$(dirname "$dest")" ]; then
    echo "skip  $dest (하네스 미설치)"
    continue
  fi
  echo "→ $dest"
  [ "$CHECK_ONLY" -eq 1 ] || mkdir -p "$dest"
  for dir in "$REPO"/skills/*/; do
    link_one "$dir" "$dest/$(basename "$dir")"
  done
done

# 전역 지침
echo "→ 전역 지침"
for dst in "${GUIDE_DESTS[@]}"; do
  if [ ! -d "$(dirname "$dst")" ]; then
    echo "  skip  $dst (하네스 미설치)"
    continue
  fi
  link_one "$GUIDE_SRC" "$dst"
done

echo
if [ "$fail" -eq 0 ]; then
  echo "전부 정상."
else
  echo "깨진 링크가 있다. 위 BROKEN 항목을 확인할 것."
  exit 1
fi
