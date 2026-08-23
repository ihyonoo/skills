# claude-skills

개인용 Claude Code 스킬 세트.

## 설치

```bash
./scripts/link.sh
```

스킬과 전역 지침을 Claude Code·Codex 양쪽에 링크한다. 원본이 없어진 이 레포의 링크는 함께 정리한다. `--check`를 붙이면 아무것도 바꾸지 않고 현재 상태만 검증한다.

```bash
./scripts/check-skills.sh
```

스킬이 [작성 규약](./AGENTS.md)을 지키는지 검사한다. frontmatter 필드, 본문 단어 수, `@` 임포트, 참조 파일 존재 여부, README 등재를 본다. 스킬을 추가하거나 고친 뒤 돌린다.

| 원본 | Claude Code | Codex |
|---|---|---|
| `skills/<name>/` | `~/.claude/skills/<name>` | `~/.codex/skills/<name>` |
| `global-instructions.md` | `~/.claude/CLAUDE.md` | `~/.codex/AGENTS.md` |

스킬 본문과 전역 지침 모두 하네스 중립으로 쓰므로 한 파일을 두 에이전트가 공유한다.

## 스킬

### 프리미티브 — 다른 스킬이 재사용

| 스킬 | 역할 |
|---|---|
| `deep-interview` | frontier 기반 라운드 인터뷰로 요구사항 확정 |
| `delegation` | 서브에이전트 위임 여부·병렬 수·모델 티어를 추천안과 함께 확인 |
| `spec-review` | 문서를 완결성·실행가능성 두 축으로 리뷰 |
| `code-review` | 코드를 정확성·정합성 두 축으로 리뷰 |

### 문서

| 스킬 | 역할 |
|---|---|
| `design` | 규모(S/M/L) 판정 → 인터뷰 → M이면 `docs/design/`, L이면 prd·trd로 |
| `prd` | 무엇을 왜 만드는지 → `docs/prd/` |
| `trd` | 어떻게 만드는지 → `docs/trd/` |

### 개발

| 스킬 | 역할 |
|---|---|
| `implement` | 확정 문서를 열어 읽고 요구사항 ID 단위로 구현. 끝나면 대조 |
| `tdd` | RED-GREEN-REFACTOR |
| `root-cause` | 재현 → 가설 → 반증 → 왜 세 번 |
| `frontend-design` | 다이얼 3개로 방향 확정 후 구조가 다른 변형 2~3개 제시. AI 티 패턴과 마감 체크리스트 포함 |

### Git

| 스킬 | 역할 |
|---|---|
| `branch-flow` | 브랜치 생성 → 커밋 → 셀프 리뷰 → PR 작성 |
| `post-merge` | 머지 후 로컬 정리 |

### 프로젝트 설정

| 스킬 | 역할 |
|---|---|
| `init` | 프로젝트 지침 파일 작성 + `AGENTS.md` ← `CLAUDE.md` 연결. 번들 `/init`를 대체한다 |

## 흐름

```
design ─┬─ (S) 문서 없이 ───────────┐
        ├─ (M) 설계 메모 ───────────┤
        └─ (L) prd → trd ──────────┤
                                   ↓
                              implement ── tdd / frontend-design / root-cause
                                   ↓
                 branch-flow (커밋 → code-review → PR) → post-merge
```

`implement`가 문서와 코드를 잇는다. 확정된 문서를 실제로 열어 읽는 것으로 시작하고, 요구사항 ID 하나가 작업 단위다.

`deep-interview`와 `spec-review`는 design·prd·trd가, `code-review`는 branch-flow가, `delegation`은 조사가 필요한 모든 스킬이 부른다.

설계 메모는 M에서만 쓴다. L은 PRD·TRD가 그 역할을 대신하므로 같은 내용을 세 번 적지 않는다.

## 호출 방법

전부 자동 발동한다(`disable-model-invocation`을 쓰지 않는다). 슬래시를 칠 필요는 없지만 `/design`처럼 이름으로 직접 호출할 수도 있다 — Claude Code에서 커스텀 커맨드는 스킬로 통합됐다.

`init`은 번들 스킬 `/init`와 이름이 같아 **그것을 덮어쓴다.** 개인 스킬이 번들 스킬보다 우선한다.

## 설계 원칙

작성 규약은 [AGENTS.md](./AGENTS.md) 참고.

경량성은 스킬 개수가 아니라 **로드 시점**으로 확보한다. 상시 비용은 description뿐이고 본문은 발동할 때만 들어온다. 그래서 스킬은 많아도 되고, 필요하면 절차가 복잡해도 된다 — 대신 `SKILL.md`는 500단어를 넘기지 않고 넘치는 것은 `references/`로 뺀다. 작업 종류에 따라 읽을 참조 파일이 갈리는 라우팅 스킬만 예외를 받는다(현재 `frontend-design` 하나).

## 출처

`frontend-design`의 디자인 규칙 일부는 [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) (MIT)에서 가져와 한국어로 재작성하고 이 저장소 범위에 맞게 압축했다.
