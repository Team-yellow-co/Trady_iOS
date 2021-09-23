//
//  FeedWriteView.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import SwiftUI
import SwiftUIFlowLayout

struct FeedWriteView: View {
    
    struct Constant {
        static let itemBorderPaddingInset: EdgeInsets = .init(top: 11,
                                                              leading: 28,
                                                              bottom: 11,
                                                              trailing: 28)
    }
    
    @ObservedObject private var viewModel: FeedWriteViewModel
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
                Button(action: {
                    print(viewModel.locationTags.sorted())
                    viewModel.send(event: FeedEvent.showTagSelectView)
                }) { Text("# 지역 태그를 선택해주세요")
                    .font(.custom("SpoqaHanSans-Bold", size: 17))
                    .foregroundColor(Color.tradyPurple)
                }
                if viewModel.locationTags.isEmpty == false {
                    ScrollView {
                        FlexibleView(data: viewModel.locationTags,
                                     spacing: 4,
                                     alignment: .leading) { item in
                            Text("# \(item.locationName)")
                                .font(.system(size: 14, weight: .heavy, design: .default))
                                .foregroundColor(.black)
                                .padding(Constant.itemBorderPaddingInset)
                                .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color.tradyGray, lineWidth: 1)
                                        )
                        }
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:   10))
            .navigationTitle("글쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                let event = FeedEvent.hideFeedWriteView(isPostWriteAction: false)
                viewModel.send(event: event)
            }, label: {
                Text("취소")
                    .font(.custom("SpoqaHanSans-Regular", size: 17))
                    .foregroundColor(Color.red)
            }), trailing: Button(action: {
                let event = FeedEvent.writeCompleted(title: title,
                                                     content: contents)
                viewModel.send(event: event)
            }, label: {
                Text("완료")
                    .font(.custom("SpoqaHanSans-Regular", size: 17))
                    .foregroundColor(Color.tradyPurple)
            }))
        }
        .fullScreenCover(isPresented: $viewModel.isTagSeletionViewShowing, content: {
            FeedTagSelectionView(viewModel: viewModel.feedTagSelectionViewModel)
        })
    }
}

struct FeedWriteView_Previews: PreviewProvider {
    static var previews: some View {
        let testVM = FeedWriteViewModel()
        FeedWriteView(viewModel: testVM)
    }
}
