# dnd-10th-9-iOS

## 🩷 Issue

- 템플릿을 사용합니다.

```
[FEAT] HomeView-NavigationBar-UI 작업
[CHORE] Colorset 세팅
```

```
[ 분류 ] 뷰이름 - UI - 작업

## 🎧 About
<!-- 해당 이슈에서 할 작업에 대해 설명해주세요. -->
* 

## 🎶 Branch Name
feat/#?-

## 🎹 To do
<!-- 해야 할 일을 적어주세요. -->
- [ ]
```
</br>

## 🧡 Branch

- 가장 처음에 붙는 분류 영역에서는, 커밋 컨벤션의 워딩과 동일하게 작성합니다.

### 💛 Branch Naming

- `분류` /`#이슈 번호` - `작업할 뷰` - `상세 작업 내역`

```swift
chore/#3-Project-Setting
feat/#3-HomeView-UI
```
</br>

## 💚 Commit

```swift
chore: 잡일 #2
feat: 새로운 주요 기능 추가 #2
add: 파일 추가 #2
fix: 버그 수정 #2
remove: 쓸모없는 코드, 파일 등 삭제 #2
refactor: 코드 리팩토링 -> 결과는 동일 #2
move: 프로젝트 구조 변경(폴더링 등) #2
rename: 파일, 클래스, 변수명 등 이름 변경 #2
docs: Wiki, README 파일 수정 #2
```
</br>

## 🩵 PR

- 템플릿을 사용합니다.
- `Assignee`에 본인을 등록합니다.
- `Reviewer`로 팀원을 등록합니다.

```
## 🎸 작업한 내용
- 작업 내용 1

## 🎶 PR Point
<!-- 피드백을 받고 싶은 부분, 공유하고 싶은 부분, 작업 과정, 이유를 적어주세요. -->
- PR Point 1
- PR Point 2

## 📸 스크린샷
<!-- gif or mp4 용량 제한이 있는데... 용량 넘어가면 슬랙으로 보내 주세요. -->

## 💽 관련 이슈
- Resolved: #이슈번호
```
</br>

## 💜 Merge
- 본인의 `PR`은 본인이 `Merge`합니다.
- 최대한 빨리, 최대 24시간 이내에 코드 리뷰(확인차원의 리뷰)를 등록합니다.
- 최신화를 자주 하자!

- 코드 리뷰를 하면서 필수적인 수정 사항을 발견할 경우, `Approve` 대신 `Request Changes`를 주어 수정을 요구합니다.
    - 해당 `PR` 작업자는, 수정 사항을 반영하여 새로 `commit`을 추가한 후, 해당 `PR`에 `push`하여 `Re-request review`를 요청합니다.
        1. `Request Changes`: 컨벤션 
        2. `Approve`: 일단 OK! 로직, 리팩토링 가능한 부분, 더 나은 코드를 위한 제안 등

- 모든 작업이 완료되어 `Merge`가 된 경우, 해당 `PR` 하단의 `Delete Branch`를 선택하여 작업이 끝난 `Branch`를 삭제합니다.
