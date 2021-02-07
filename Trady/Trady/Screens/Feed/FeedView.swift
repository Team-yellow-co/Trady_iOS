//
//  FeedView.swift
//  Trady
//
//  Created by bumslap on 2021/01/25.
//

import SwiftUI

struct Feed: View {
    var post: Post
    
    var dateString: String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(post.createDate))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"

        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading,
                   spacing: 10) {
                Text("\(post.title)")
                    .font(.title)
                Text("\(post.contents)")
                    .lineLimit(2)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                Text("\(post.writerName)")
                    .foregroundColor(Color(.darkGray))
                Text("\(dateString)")
                    .foregroundColor(Color(.darkGray))
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 25)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
        }
    }
}

struct FeedView: View {
    
    @State var posts: [Post] = Post.data
    
    private let columns = [GridItem(.fixed(UIScreen.main.bounds.size.width))]
    
    var body: some View {
        ZStack {
            Color(red: 241/255, green: 241/255, blue: 241/255)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns,
                          spacing: 10) {
                    ForEach(posts, id: \.postId) { post in
                        Feed(post: post)
                            .frame(width: UIScreen.main.bounds.size.width,
                                   height: 250)
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
