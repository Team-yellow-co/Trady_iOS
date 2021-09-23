//
//  FeedCellView.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import SwiftUI

struct FeedCellView: View {
    let idTextFont: Font = .system(size: 15,
                                   weight: .bold,
                                   design: .default)
    let dateTextFont: Font = .system(size: 12,
                                     weight: .regular,
                                     design: .default)
    let contentTextFont: Font = .system(size: 17,
                                        weight: .light,
                                        design: .default)
    let viewCountTextFont: Font = .system(size: 12,
                                        weight: .light,
                                        design: .default)
    
    private var viewModel: FeedCellViewModel
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(width: 0, height: 15, alignment: .leading)
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 15, height: 50, alignment: .leading)
                Image("apple_logo")
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(17.5)
                Spacer()
                    .frame(width: 10, height: 50, alignment: .leading)
                VStack(alignment: .leading) {
                    Spacer()
                    Text(viewModel.title)
                        .font(idTextFont)
                    Text(viewModel.createdAt)
                        .font(dateTextFont)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                .frame(width: 200,
                        height: 50, alignment: .leading)
                
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Image("feed_more")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .top)
                    Spacer()
                        .frame(width: 0,
                               height: 10,
                               alignment: .top)
                }
                .frame(width: 15, height: 50, alignment: .trailing)
                
                Spacer()
                    .frame(width: 15, height: 50, alignment: .trailing)
            }
            Spacer()
                .frame(width: UIScreen.main.bounds.width,
                       height: 15)
            HStack() {
                Spacer()
                    .frame(width: 15,
                           height: 0,
                           alignment: .leading)
                Text(viewModel.contentText)
                    .lineLimit(5)
                    .font(contentTextFont)
                Spacer()
                    .frame(width: 15,
                           height: 0,
                           alignment: .trailing)
            }
            Spacer()
                .frame(width: 0, height: 15, alignment: .trailing)
            HStack {
                Spacer()
                Text("조회 수 \(viewModel.viewCountText)")
                    .font(viewCountTextFont)
                    .foregroundColor(Color.gray)
                Spacer()
                    .frame(width: 15, height: 0, alignment: .trailing)
                
            }
            Spacer()
                .frame(width: UIScreen.main.bounds.width,
                       height: 25)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width,
                       height: 10)
                .foregroundColor(Color(red: 236/255,
                                       green: 236/255,
                                       blue: 236/255))
                
        }
    }
}

struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        let testPost = Post(title: "testTitle",
                            id: "testid",
                            content: "somebody to love", profileImageUrl: nil,
                            likeCount: 10, viewCount: 20,
                            createdAt: .init(),
                            tags: [])
        let testVM = FeedCellViewModel(post: testPost)
        FeedCellView(viewModel: testVM)
    }
}
