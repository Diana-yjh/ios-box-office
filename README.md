## 박스오피스 II

### 목차
- [1. 소개](#1-소개)
- [2. 팀원](#2-팀원)
- [3. 타임라인](#3-타임라인)
- [4. 트러블 슈팅](#4-트러블-슈팅)
- [5. 팀 회고](#5-팀-회고)
- [6. 참고 자료](#6-참고-자료)

---
### 1. 소개
- 박스오피스 앱은 영화진흥위원회의 일별 박스오피스와 영화 상세정보 OPEN API로부터 데이터를 받아와 어제의 박스오피스 순위를 출력해줍니다. 또한 해당 영화를 클릭하면 영화 상세정보를 볼 수 있습니다.

### 2. 팀원
| <img src="https://avatars.githubusercontent.com/u/154333967?v=4" width="200"> | <img src="https://avatars.githubusercontent.com/u/57698939?v=4" width="200"> | <img src="https://avatars.githubusercontent.com/u/96014314?v=4" width="200"> |
| :-: | :-: | :-: |
| Danny ([Github](https://github.com/dannykim1215)) | Diana ([Github](https://github.com/Diana-yjh)) | gama ([Github](https://github.com/forseaest))

### 3. 타임라인
| 날짜 | 제목 |
| --- | --- |
| 24.04.15(월) ~ 04.16(화) | 1. `CollectionView` 기초 구현(UICollectionCompositionalLayout 이용) 2.`BoxOfficeCell` 구현<br/> 3.`RefreshControl` 추가 구현<br/>4.`CalenderViewController` 구현<br/> 5.`UIActivityIndicatorView`를 활용하여 앱 시작할 때, 날짜 변경했을 때의 로딩뷰 구현<br/>6. 재사용 셀 관련해서 `prepareForReuse()` 메소드를 통한 초기화   |
| 24.04.17(수) | 1. `StackView` 중첩 제거<br/>2. 접근제어자 키워드 활용하여 외부에서 보지 않아도 되는 프로퍼티 및 메소드를 캡슐화 |
| 24.04.18(목) ~ 04.19(금) | 1. CalendarViewController 내부의 Delegate 메소드 extension으로 분리<br/>2. BoxOffice에 대한 `BoxOfficeDTO` 모델 구현<br/>3. 화면모드변경 버튼 구현 및 Alert 추가 |
| 24.04.22(월) | 1. 화면모드변경에 따른 아이콘, 리스트 분기<br/>2. 아이콘 화면모드에 맞는 레이아웃 추가 구현<br/>3. 카카오API와 네트워킹을 위한 `KaKaOSearchData` 모델 구현, 카카오 API 추가<br/>4. `MovieDetailViewController` 화면 구현 |
| 24.04.23(화) | 1. `Dynamic Type` 구현<br/>2. `UserDefaults`를 사용하여 이전에 사용했던 화면모드를 이어서 보여주기 구현<br/>3. KaKaoSearchData의 DTO 모델 구현, 카카오 검색 API를 위한 `loadKakaoSearchAPI()` 함수 구현 |
| 24.04.24(수) | 1. `MovieInformation`의 DTO 모델 구현, List에 다이내믹 타입 적용 |
| 24.04.25(목) | 1. 영화 상세 화면에서 제목 라벨들이 다이나믹 타입에 의해 잘리거나 줄어드는 현상 해결 |
| 24.04.26(금) | 1. NetworkService 싱글톤 적용 및 코드 리팩토링<br/> 2. 리드미 작성<br/> 3. STEP 2 PR 작성 |


### 4. 트러블 슈팅
#### 1. ❗️**BoxOffice 앱을 종료하고 실행했을 때, 이전 화면모드(List, Icon) 유지하는 방법**
##### 📌 문제 상황
- 사용자가 `BoxOffice` 앱을 종료하고 실행했일 때, 마지막으로 사용했던 화면모드를 유지하고 싶었습니다. 해당 기능을 구현하기 위해 고민한 결과, `cellMode` 값을 앱이 종료되더라도 저장이 되어야 한다고 생각했습니다. 해당 값을 저장하는 방법을 생각해야했습니다.

##### 🛠️ 해결 방법
- `cellMode`값을 저장하는 방법으로 `UserDefaults` 를 사용하기로 했습니다. `UserDefaults` 를 사용해도 된다고 판단한 이유는 화면모드 자체는 중요한 정보는 아니라고 생각했고, 앱이 종료되더라도 저장된 값이 그대로 갖고 있어야 했기 때문입니다.
- 먼저, 앱을 실행했을 때 `UserDefaults` 를 통해 저장되어 있는 cellMode 값을 불러와 레이아웃을 구성하게 하였습니다. 
```swift
class ViewController: UIViewController {
	...
	private var defaults = UserDefaults.standard
	private lazy var cellMode: CellMode = (defaults.value(forKey: "modeKey") as? String ?? "리스트" == "리스트") ? .list : .icon
	...
	override func viewDidLoad() {
		switch self.cellMode {
		case .list:
			self.collectionView.collectionViewLayout = self.createCollectionViewListLayout()
			self.configureDataSource(.list)
			self.configureUI()
		case .icon:
			self.collectionView.collectionViewLayout = self.createCollectionViewIconLayout()
			self.configureDataSource(.icon)
			self.configureUI()
		}	
		
	}
	
}
```
- Key 값은 `modeKey`로 세팅하였으며, `defaults.value(forKey: "modeKey")` 메소드를 통해서 만약 nil 이라면 "리스트" 값을 무조건 불러오게 하였습니다. 삼항연산자를 통해서 값이 "리스트" 라면 cellMode 변수에 `.list`로 할당했고, "리스트"가 아니라면 "아이콘"이므로 cellMode 변수에 `.icon`을 할당했습니다.

- 그렇다면, 사용자가 앱을 종료하기 직전에 보고있던 화면모드 값을 UserDefaults 에 저장해야한다고 생각했습니다. 화면모드를 변경하는 changeMode 메소드 내부에서 분기처리 할 때 `defaults.setValue(, forKey:)` 메소드를 활용해서 해당 `cellMode` 값을 저장하도록 하였습니다.
```swift
@objc private func changeMode(sender: AnyObject) {
	...
	let action = UIAlertAction(title: "\(cellMode.name)", style: .default) { _ in
	    self.defaults.setValue(self.cellMode.name, forKey: "modeKey")
            switch self.cellMode {
            case .list:
                self.collectionView.collectionViewLayout = self.createCollectionViewListLayout()
                self.configureDataSource(.list)
                self.configureUI()
            case .icon:
                self.collectionView.collectionViewLayout = self.createCollectionViewIconLayout()
                self.configureDataSource(.icon)
                self.configureUI()
        }
																		   }
}
```


#### 2. ❗️Icon 뷰의 ContentView와 GridStackView의 레이아웃 관련 문제
##### 📌 문제 상황
- Icon 뷰의 GridStackView가 상위 뷰인 ContentView와 레이아웃이 일치하기 때문에 GridStackView가 리소스를 가중시키는 문제가 있었습니다.
```swift
[gridStackView].forEach {
	self.contentView.addSubview($0)
}

[rankNumberLabel, movieTitleLabel, rankChangeLabel, audienceLabel].forEach {
	self.gridStackView.addArrangedSubview($0)
}

NSLayoutConstraint.activate([
	gridStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
	gridStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
	gridStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
	gridStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
])
```
##### 🛠️ 해결 방법
- GridStackView를 제거하고, contentView에 해당 컴포넌트들(rankNumberLabel, movieTitleLabel, rankChangeLabel, audienceLabel)를 직접 서브뷰에 할당을하고 레이아웃을 잡아줬습니다. 그리하여, 불필요한 StackView를 제거할 수 있었습니다.
```swift
[rankNumberLabel, movieTitleLabel, rankChangeLabel, audienceLabel].forEach {
	$0.numberOfLines = 0
	$0.textAlignment = .center
	self.contentView.addSubview($0)
}

NSLayoutConstraint.activate([
	rankNumberLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
	movieTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
	rankChangeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
	audienceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),

	rankNumberLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
	movieTitleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
	rankChangeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
	audienceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),

	rankNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
	movieTitleLabel.topAnchor.constraint(equalTo: rankNumberLabel.bottomAnchor),
	rankChangeLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
	audienceLabel.topAnchor.constraint(equalTo: rankChangeLabel.bottomAnchor)
])
```

#### 3. ❗️**카카오 검색 API와 통신하는 함수**

##### 📌 문제 상황

영화 상세 화면에서 영화 포스터의 이미지를ㅌ₩ 띄워주기 위한 카카오 검색 API를 보다 범용적으로 네트워킹하는 메소드를 구현하려고 했습니다.

##### 🛠️ 해결 방법

먼저, 카카오 검색 API의 검색 파라미터들은 공통적으로 원하는 검색어와 이외의 검색 옵션들을 선택적으로 추가할 수 있습니다.

| 이름 | 타입 | 설명 | 필수 |
| --- | --- | --- | --- |
| query | String | 검색을 원하는 질의어 | O |
| sort | String | 결과 문서 정렬 방식, accuracy(정확도순) 또는 recency(최신순), 기본 값 accuracy | X |
| page | Integer | 결과 페이지 번호, 1~50 사이의 값, 기본 값 1 | X |
| size | Integer | 한 페이지에 보여질 문서 수, 1~80 사이의 값, 기본 값 80 | X |

함수의 파라미터들에 이 검색 옵션들을 개별적으로 설정하게 하거나 튜플을 사용하는 것보다, 하나의 데이터로 표현하는 것이 한데 모아 보다 코드를 이해하고 읽기 쉬울 것으로 판단하여, 구조체로 구현했습니다.

```swift
struct KakaoSearchOption {
    var query: String
    var sort: searchResultSortingOption?
    var page: Int?
    var size: Int?
    
    enum searchResultSortingOption: String {
        case accuracy
        case recency
    }
}
```

그리고 함수의 파라미터로 받은 검색 옵션은 URLComponents의 queryItems을 통해 URL로 구성되게 만들어줬습니다. accuracy이 기본값이므로, 만약에 sort로 입력 받은 값이 nil일 때를 대비해 닐 코어레싱으로 accuracy를 지정시켰습니다.

```swift
urlComponents.queryItems = [
    URLQueryItem(name: "query", value: searchOption.query),
    URLQueryItem(name: "sort", value: searchOption.sort?.rawValue ?? KakaoSearchOption.searchResultSortingOption.accuracy.rawValue),
    URLQueryItem(name: "page", value: String(searchOption.page ?? 1)),
    URLQueryItem(name: "size", value: String(searchOption.page ?? 1)),
]
```

API 키를 헤더에 담아 GET으로 요청하고, task를 만든 후 resume()으로 네트워크 작업을 시작하게 했습니다.

```swift
var urlRequest = URLRequest(url: url)
urlRequest.httpMethod = "GET"
urlRequest.setValue("KakaoAK \(URLs.kakaoApiKey)", forHTTPHeaderField: "Authorization")
```

카카오 검색 API에는 현재 프로젝트에서 필요한 이미지뿐만 아니라 웹문서, 동영상, 블로그 등을 검색할 수 있습니다. 다른 분야들을 검색하고 싶다면 해당 분야의 케이스와 URL 문자열과 분기 처리를 추가하고, 네트워킹 타입을 구현하기만 하면 되도록 함수를 구현했습니다.

```swift
enum KakaoSearchType {
    case image
    
    var urlString: String {
        switch self {
        case .image:
            return "\(URLs.KAKAO_IMAGE_SEARCH)"
        }
    }
}
```

#### 4. ❗️**다이나믹 타입 변경에 따른 오토 레이아웃 적용**

##### 📌 문제 상황

폰트에 다이타믹 타입을 적용함에 따라 영화 상세 화면에서 상세 정보들의 타이틀 라벨들의 너비가 일정하지 않아 말줄임표로 내용이 보이지 않거나 잘리는 상황이 발생했습니다. 

##### 🛠️ 해결 방법

스크린샷을 살펴본 결과, 타이틀 라벨들의 각 너비가 가장 긴 상영등급 라벨의 너비에 맞춰져 있는 것을 확인했습니다. 따라서 `movieWatchGradeNameTitleLabel.intrinsicContentSize.width`를 변수로 빼놓고 타이틀 라벨들의 widthAnchor를 상영등급 라벨의 width와 맞춰지도록 하는 함수를 만들어, viewDidLoad와 viewWillAppear에서 호출되도록 해주었습니다. 그러나 width가 2개가 설정되므로 충돌되는 에러가 발생하여 원하는 화면으로 구현되지 않았습니다.

NotificationCenter에 시스템에서 폰트 카테고리가 변경되었을 때 post를 주는 채널인 `UIContentSizeCategory.didChangeNotification`을 등록하고, 알림을 받았을 때 widthAnchor를 업데이트하는 함수를 호출되게 만들었습니다. 다이나믹 타입을 적용하는 것을 감지하지만 여전히 타이틀 라벨들의 너비는 알맞게 적용되지 못하고 있었습니다.

혹시 카테고리화를 위해 타이틀 라벨과 내용값 라벨을 하나의 스택뷰로 묶어주고 개별적인 오토 레이아웃들을 적용시키지 않아서가 아닐까 생각하고, 스택뷰들을 삭제하고 타이틀 라벨들의 trailingAnchor를 너비가 가장 긴 상영등급 라벨의 trailingAnchor와 맞춰주었습니다. 그 결과 다이나믹 타입을 적용할 때마다 타이틀 라벨들의 너비가 해당 다이나믹 타입의 크기에 맞게 설정되고, 라벨의 내용물이 줄어들지 않는 것을 확인하고 해결했습니다.


### 5. 팀 회고
#### 우리팀이 잘한 점 😍
- Danny
  - 각자 맡은 부분을 포기하지 않고 끝까지 최선을 다해 구현한 부분과 이해가 안되는 부분을 물어봤을 때 서로가 설명해주고자 했던 부분이 잘한 것 같습니다. 코딩 컨벤션도 잘 지켰다고 생각합니다.
- Diana 
  - 추후 작성 예정
- gama 
  - 자신이 맡은 코드에 대해 필수적으로 설명하여 팀 프로젝트를 진행하여 코드의 이유에 대해 사유할 수 있었던 좋은 기회였습니다.

#### 우리팀 개선할 점 🥲
- Danny
  - 프로젝트와 관련된 내용들을 모두 이해하기에 많은 시간이 필요하기 때문에, 완벽하게 다 이해는 하지 못하고 프로젝트를 수행했었던 것 같습니다. 각자 시간을 더 투자해서 개념이나 코드를 리팩토링 하는 등 노력이 필요할 것으로 보입니다.
- Diana
  - 추후 작성 예정
- gama
  - 네트워킹과 모던 콜렉션뷰의 사용이 미숙하였고, 다이나믹 타입 적용에 따른 레이아웃 변화가 매우 어려워 시간이 오래 걸린 점이 아쉽습니다.

### 6. 참고 자료
- [Apple 공식문서 - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple 공식문서 - Fetching website data into memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Apple 공식문서 - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [Apple 공식문서 - UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)
- [Apple 샘플 코드 - Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [WWDC-Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [WWDC-Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
- [Swift - 특정 문자열의 속성 변경](https://ios-development.tistory.com/654)
- [Apple 공식문서 - UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- [Apple 공식문서 - UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
