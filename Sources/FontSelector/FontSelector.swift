//
//  FontSelector.swift
//  FontSelectorDemo
//
//  Created by Shunzhe Ma on R 2/09/21.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

public enum FontSelectorOption {
    // テーブル内にフォント名を表示
    case displayFontNameAsSubtitle
}

@available(iOS 13.0, *)
public struct FontSelector: View {
    
    private var allFonts: [String] = []
    private var demoText: String
    private var options: [FontSelectorOption]
    private var onFontSelected: (String) -> Void
    private var textColor: Color
    
    @State private var searchText: String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    
    /**
     - onFontSelected: この機能はユーザーがフォントを選択すると呼び出されます。
     - demoText: これは表示デモ目的のためのテキスト内容です。デフォルト値は `あ ア 亜` に設定されています
     - displayAllLocalFonts: この変数を真に設定すると、すべてのシステムフォントをメニューに表示します。
     - customFontNames: フォントの一部のみ表示したい場合は、`displayAllLocalFonts` を偽に設定し、フォントを選択して `customFontNames` に追加してください。
     - options: 上の `FontSelectorOption` コードで指定されているように、複数の選択肢から選択することができます。
     - textColor: 文字の色
     */
    public init(onFontSelected: @escaping (String) -> Void, demoText: String = "あ ア 亜", displayAllLocalFonts: Bool = true, customFontNames: [String] = [], options: [FontSelectorOption] = [.displayFontNameAsSubtitle], textColor: Color = .primary) {
        self.demoText = demoText
        if displayAllLocalFonts {
            // 全てのローカルフォントを追加する
            let fontFamilies = UIFont.familyNames
            for fontFamily in fontFamilies {
                let fontNames = UIFont.fontNames(forFamilyName: fontFamily)
                allFonts.append(contentsOf: fontNames)
            }
        }
        // 追加したフォントに名前をつける
        allFonts.append(contentsOf: customFontNames)
        // オプションの設定を行う
        self.options = options
        self.onFontSelected = onFontSelected
        self.textColor = textColor
    }
    
    public var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("フォントの検索", text: $searchText)
                            .cornerRadius(8)
                    }
                    
                }
                
                Section {
                    
                    ForEach(allFonts.filter({ (fontName) -> Bool in
                        // 検索バーに文字列がない場合は、trueを返す
                        if searchText == "" {
                            return true
                        }
                        // 文字列がある場合は、フォント名と検索文字列が一致しているか確認する必要ならサブタイトルを表示する
                        return fontName.lowercased().contains(searchText.lowercased())
                    }), id: \.self, content: { fontName in
                        Button(action: {
                            onFontSelected(fontName)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            VStack(alignment: .leading, spacing: nil, content: {
                                Text(demoText)
                                    .font(.init(UIFont(name: fontName, size: 30) ?? .systemFont(ofSize: 15)))
                                    .padding(.top, 10)
                                    .foregroundColor(textColor)
                                // Display a subtitle, if necessary
                                if options.contains(.displayFontNameAsSubtitle) {
                                    Text(fontName)
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                }
                            })
                        })
                        .buttonStyle(PlainButtonStyle())
                    })
                    
                }
                
            }
            .navigationBarTitle("フォントセレクター", displayMode: .inline)
            
        }
        
    }
    
}
