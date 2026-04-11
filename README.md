Tonywack26SSInspired - SwiftUI Lookbook App

<br>

> 의류 브랜드 Tonywack 26SS 시즌 무드를 기반으로
이미지 중심의 몰입형 제품 탐색 경험을 제공하는 룩북 스타일 SwiftUI 앱입니다.


<br>

----

<br>

## ✨ Features

```
- 이미지 중심의 몰입형 Scroll View UI
- Firestore + Firebase Storage 기반 실시간 상품 데이터 관리
- 좌측 메뉴View를 통한 카테고리 필터링
- 우측 서치View를 통한 가격 및 검색 Range 필터링
- async/await 기반 비동기 데이터 처리
```

<br>

----

<br>


<h2 align="center">📺 Preview</h2>

<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ba9034e4-fddb-42cc-b84f-0b469ae219f7" width="240">
  <img src="https://github.com/user-attachments/assets/cc7a146f-9b4d-4549-91c5-3e100f3d1eb0" width="240">
  <img src="https://github.com/user-attachments/assets/560c8be7-21bb-45d3-89c5-256a637597e6" width="240">
</p>

<p align="center">
  <sub>로딩, 메인뷰 Loading & Main Scroll</sub>
  &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;
  <sub>메뉴뷰 카테고리 변경 Category Change</sub>
  &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;
  <sub>검색뷰 서치필터 Search Filter</sub>
</p>



<br>

----

<br>


## 🛠 Tech Stack
* Language: Swift
* UI Framework: SwiftUI
* Architecture: MVVM
* Network: Firebase SDK + URLSession (KingFisher)
* Backend : Firebase Firestore, Firebase Storage
* dependency : Firebase, KingFisher

<br>

----

<br>

## Architecture

* MVVM 패턴 기반 구조
* View ↔ ViewModel 데이터 바인딩
* RootView에서 앱 상태(로딩/메인) 흐름 제어
* Firestore 데이터 → ViewModel → View 반영통신 처리


<br>

---

<br>

## Firestore Database Structure


```
products
 └ product
    ├ id
    ├ name
    ├ price
    ├ category
    └ imageUrls
```

<br>

---

<br>
    

## File Tree -프로젝트 구조


```text

Tonywack26SSInspired
├── App
│   ├── Tonywack26SSInspiredApp
│   ├── RootView
│   └── LoadingView
│
├── Models
│   ├── Product
│   └── Category
│
├── View
│   ├── ProductView 
│   ├── ProductDetailView
│   ├── MenuView   
│   └── SearchView
│
├── ViewModel
│   └── ProductViewModel 
│
├── UIHelpers
│   └── ScrollPositionPreferenceKey
│
└──  Assets
   └── Assets.xcassets  
```



<br>

----

<br>


## Technical Challenges & 트러블슈팅 Troubleshooting


### :one: Scroll 기반 Focus UI 구현
#### ❗ 문제
SwiftUI상에서 scroll.offset 접근방식이 어려워 PreferenceKey와 GeometryReader를 활용해 각 셀의 위치를 수집하고 화면 중앙과 가장 가까운 요소를 계산하는 방식으로 구현

#### ✅ 해결
* GeometryReader + PreferenceKey를 활용하여 현재 화면 중앙에 위치한 아이템을 실시간으로 추적

* 가장 가까운 아이템을 selectedIndex로 설정하여
  선택된 상품에만 Focus 효과 적용

* Blur / Opacity 처리를 활용해 선택된 index에 시야가 집중되도록 UI 구현



<p align="center">
  <img src="https://github.com/user-attachments/assets/dd13ef3f-080e-4100-96a6-e883fb0f6aa9" width="200"><br>
  <sub>중앙에 위치한 상품이 자동으로 강조되는 Focus UI</sub>
</p>


```swift

// ScrollPositionPreferenceKey
struct ScrollPositionPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

// ProductView
.background(
            GeometryReader { geo in
                    Color.clear.preference(
                        key: ScrollPositionPreferenceKey.self,
                        value: [index: geo.frame(in: .global).midY]
                    )
            }
     )

     
let screenCenter = UIScreen.main.bounds.height / 2
let closest = values.min(by: { abs($0.value - screenCenter) < abs($1.value - screenCenter) })
                
if let index = closest?.key {
                    selectedIndex = index
    }
 }


```

<br>

---


### :two: 좌측 Index Visible Range 최적화

#### ❗ 문제
이미지 중심의 ScrollView에서 모든 상품 인덱스를 좌측 혹은 하단에 나열할 경우 UI가 복잡해지고 현재 선택된 이미지에 대한 집중도가 떨어지는 문제가 있었습니다.

또한, 전체 인덱스를 모두 텍스트로 렌더링할 경우 불필요한 렌더링이 발생할 수 있었습니다.

#### ✅해결
스크롤뷰 좌측에 인덱스 텍스트를 배치하되 선택된 인덱스를 기준으로 일정 범위만 노출하는 Visible Range를 적용하여 UI를 단순화하고 현재 콘텐츠에 집중할 수 있도록 개선했습니다

<p align="center">
  <img src="https://github.com/user-attachments/assets/b2636bd6-13d9-436f-9e7c-f3712be1c821" width="200"><br>
  <sub>Index Visible Range</sub>
</p>


```swift

    if visibleRange.contains(index) {
    Text(viewModel.filteredProducts[index].id)
        .foregroundColor(index == selectedIndex ? .black : .gray)
        .font(index == selectedIndex ? .headline : .subheadline)
        .scaleEffect(index == selectedIndex ? 1.1 : 0.9)
        .opacity(index == selectedIndex ? 1 : 0.7)
        .animation(.easeInOut(duration: 0.2), value: selectedIndex)
        .onTapGesture {
            selectedIndex = index
        }
}
```

<br>

---



### :three: 오버레이 기반 UI 인터랙션

#### ❗ 문제
Side View를 push 방식으로 화면전환시키기엔 UI의 일관성과 몰입도를 유지하기 어렵다는 점이 있었습니다


#### ✅ 해결
기존 화면 위에 UI를 덧씌우는 Overlay(ZStack) 구조를 도입하여 메뉴(Menu)와 검색(Search) 패널을 구성해 UI 흐름을 자연스럽게 연결했습니다.

* ZStack을 활용해 메인 콘텐츠 위에 사이드뷰를 레이어 형태로 UI 배치
* dimmed background를 적용해 현재 활성화된 UI에 집중도 향상
```swift
Color.black.opacity(isMenuOpen ? 0.4 : 0)
```
* offset + animation을 활용해 좌/우 슬라이드 방식의 자연스러운 전환 구현

<p align="center">
  <img src="https://github.com/user-attachments/assets/0165d917-b2a9-48d0-bdd8-1bf73e2f5f7c" width="200"><br>
  <sub>양측 사이드바 offset + animation</sub>
</p>



<br>

---

###  :four: MVVM 실시간 상태 동기화

#### ❗ 문제 
카테고리, 검색어, 가격 범위 등 여러 필터 조건이 동시에 존재하는 상황에서 각 상태 변경 시마다 필터링 로직을 개별적으로 호출해야 하는 구조는 코드 중복 증가, 상태 간 의존성 관리 어려움, UI와 데이터 간 동기화 불일치 문제를 발생시킬 수 있었습니다.


#### ✅ 해결
각 필터 상태를 @Published로 선언하고, didSet을 활용하여 상태가 변경될 때마다 공통 필터 함수(applyFilters)가 자동으로 실행되도록 구조를 설계했습니다.

```swift
@Published var selectedCategory: Category = .outer {
    didSet { applyFilters() }
}

@Published var searchText: String = "" {
    didSet { applyFilters() }
}

@Published var minPrice: Double = 0 {
    didSet { applyFilters() }
}
```

또한, 모든 필터 로직을 하나의 함수로 통합하여
상태 변경 시 일관된 결과를 유지하도록 구현했습니다.

```swift
func applyFilters() {
    var result = products

    result = result.filter { $0.category == selectedCategory }

    if !searchText.isEmpty {
        result = result.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    result = result.filter {
        $0.price >= Int(minPrice) && $0.price <= Int(maxPrice)
    }

    filteredProducts = result
}
```

<br>

---


###  :five: LoadView 비동기 처리 기반 화면 전환

#### ❗ 문제
초기 로딩 화면을 일정 시간 기준으로 전환할 경우, 실제 데이터 로딩 상태와 무관하게 화면이 전환되어 
* 데이터가 아직 준비되지 않은 상태에서 MainView가 노출되거나 
* 반대로 불필요하게 로딩 화면이 길게 유지
되는 문제가 발생할 수 있었습니다.

#### ✅ 해결
RootView에서 비동기 데이터 로딩을 직접 관리하고, 데이터 로딩이 완료된 시점을 기준으로 화면 전환이 이루어지도록 구현했습니다.


```swift
//RootView
private func loadData() {
    Task {
        await viewModel.fetchProductsData()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        isLoading = false
    }
}
```











