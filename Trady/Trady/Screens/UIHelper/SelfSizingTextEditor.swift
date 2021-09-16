//
//  ㅇㅇㅇ.swift
//  Trady
//
//  Created by USER on 2021/09/06.
//

import Foundation
import Combine
import SwiftUI
import Introspect

struct SelfSizingTextEditor: View {
    
    let placeholerString: String
    let textCountLimit: Int?
    private let contentsFont: Font = .system(size: 16,
                                             weight: .regular,
                                             design: .default)
    @Binding var contents: String
    @State private var textEditorHeight : CGFloat = 100
    @State private var isShowingPlaceholder = true
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(isShowingPlaceholder ? placeholerString : contents)
                .modifier(SelfSizingTextEditorModifier(isShowingPlaceholder: isShowingPlaceholder))
                .background(GeometryReader {
                    Color.clear
                        .preference(key: ViewHeightKey.self,
                                    value: $0.frame(in: .local).size.height)
                    
                })
            
            TextEditor(text: $contents)
                .padding(EdgeInsets(top: -7, leading: -3, bottom: -5, trailing: -7))
                .frame(height: textEditorHeight + 12)
                .font(contentsFont)
                .foregroundColor(.black)
                .introspectTextView(customize: { textView in
                    textView.becomeFirstResponder()
                    textView.backgroundColor = .clear
                })
                .background(Color.clear)
                .onChange(of: contents,
                          perform: { _ in
                            
                    if self.contents.isEmpty {
                        self.isShowingPlaceholder = true
                    } else {
                        self.isShowingPlaceholder = false
                    }
                    if let limit = textCountLimit {
                        contents = String(contents.prefix(limit))
                    }
                })
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct SelfSizingTextEditorModifier: ViewModifier {
    
    private let isShowingPlaceholder: Bool
    private let placeholderFont: Font = .system(size: 16,
                                                weight: .light,
                                                design: .default)
    
    init(isShowingPlaceholder: Bool) {
        self.isShowingPlaceholder = isShowingPlaceholder
    }
    
    func body(content: Content) -> some View {
        return content
            .font(placeholderFont)
            .foregroundColor(isShowingPlaceholder ? .gray : .clear)
    }
}

