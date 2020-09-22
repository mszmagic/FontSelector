#  FontSelector (フォントセレクター) - SwiftUI

<img width="500" alt="image" src="https://github.com/mszmagic/FontSelector/blob/master/social-image.png?raw=true">

これは、SwiftUIで書かれたフォントセレクターです。このフォントセレクターを表示させると、ユーザーがフォントを選ぶことができます。

## 使い方

フォントセレクターを初期化するには、このコードを使います：

```swift
FontSelector(onFontSelected: { selectedFontName in
    print(selectedFontName)
})
```

フォントセレクターを提示するには、このコードを使うことができます：

```swift
@State private var showingFontSelector = false
Button("Show font selector") {
    self.showingFontSelector = true
}
.sheet(isPresented: $showingFontSelector, content: {
    FontSelector(onFontSelected: { selectedFontName in
        print(selectedFontName)
    })
})
```

オプションでパラーメーターをいくつか設定できます：

```swift
public init(onFontSelected: @escaping (String) -> Void, demoText: String = "あ ア 亜", displayAllLocalFonts: Bool = true, customFontNames: [String] = [], options: [FontSelectorOption] = [.displayFontNameAsSubtitle])
```

こちらは、パラメーターの説明です：


## インストール方法：

### Swift Package Manager

1. Xcode内からプロジェクトを開く
2. 上部のシステムバーの"File"をクリック
3. "Swift Packages"をクリック、次いで"Add package dependency…"をクリック
4. 以下のURLをペースト：`https://github.com/mszmagic/FontSelector.git`
5. Version: Up to Next Major `1.0.0 <`
6. "Next"をクリック
7. "Done"をクリック。
