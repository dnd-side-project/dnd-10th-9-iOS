# dnd-10th-9-iOS
# 💻 Code Convention

## 🩷 빈 줄

- 빈 줄에는 공백이 포함되지 않도록 합니다.
- `주석` 위에는 빈 줄이 필요합니다.
- 함수, 클래스, 구조체, 익스텐션, 프로토콜, 열거형은 빈 줄로 구분합니다.
- 인스턴스는 기본적으로 빈 줄을 넣지 않으나 목적에 따라 빈 줄로 구분합니다.
- 빈 줄이 있어야 가독성이 좋아지는 부분은 **주관적으로 판단 후** 빈 줄을 삽입합니다.

## 🧡 네이밍

- temp, profile1, a, i, 등의 의미없는 네이밍은 지양합니다.
- UpperCamelCase
  ```
  클래스, 구조체, 익스텐션, 프로토콜, 열거형(enum) 등
  ``` 
- lowerCamelCase
  ```
  함수, 메서드, 인스턴스, 열거형(enum)의 각 case 등
  ```

### 함수

- 함수는 `동사 + 목적어` 형태를 사용합니다.
- `didTap~` 은 `.touchUpInside`에 대응합니다.
- UI 세팅, 어쩌고 세팅 등은 `set + 목적어` 형태를 사용합니다.
  ```
  func setTableView()
  func setCollectionView()
  func setData()
  ```

### 약어

- ID와 Id
  ```
  userId (o) (추후 서버와의 협의를 통해 변경될 수 있음)
  userID (x)

  imageUrl(o)
  imageURL(x)
  ```
- 약어 사용 범위 외의 것들은 모두 full name으로 표기합니다.
  ```
  password (pw (x))
  button (btn (x))
  image (img (x))
  ```
## 💛 타입

- `Array<T>`와 `Dictionary<T: U>` 보다는 `[T]`, `[T: U]`를 사용합니다.
  ```
  var messages: [String]?
  var names: [Int: String]?
  ```
## 💚 주석

- `// MARK:` `// TODO:` 주석은 자유롭게 사용합니다.
- `///` 문서화에 사용되는 주석을 남깁니다.

## 🩵 파일명

- Class, Struct, Enum, Protocol 등의 이름으로 파일명을 정합니다.
- extension 파일의 경우, 파일명 뒤에 + 를 추가합니다.
  ```
  UIView+.swift
  String+.swift
  ```

# ⛙ Git Convention
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
