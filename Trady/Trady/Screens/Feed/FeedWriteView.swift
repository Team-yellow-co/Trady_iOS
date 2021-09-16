//
//  FeedWriteView.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import SwiftUI

struct FeedWriteView: View {
    private var viewModel: FeedWriteViewModel
    @State private var title: String = ""
    @State private var contents: String = ""
    init(viewModel: FeedWriteViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(width: 15,
                           height: 15,
                           alignment: .center)
                SelfSizingTextEditor(placeholerString: "여기를 눌러 제목을 입력해주세요",
                                     textCountLimit: 20,
                                     contents: $title)
                Divider()
                SelfSizingTextEditor(placeholerString: "여기를 눌러 내용을 입력해주세요",
                                     textCountLimit: nil,
                                     contents: $contents)
                Spacer()
                    .frame(width: 20,
                           height: 20,
                           alignment: .center)
                Text("# 지역 태그 선택")
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:   10))
            .navigationTitle("글쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("X")
            }), trailing: Button(action: {
                let event = FeedEvent.writeCompleted(title: title,
                                                     content: contents,
                                                     tags: [])
                viewModel.send(event: event)
            }, label: {
                Text("완료")
            }))
        }
    }
}

struct FeedWriteView_Previews: PreviewProvider {
    static var previews: some View {
        let testVM = FeedWriteViewModel()
        FeedWriteView(viewModel: testVM)
    }
}
