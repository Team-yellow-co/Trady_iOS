//
//  Post.swift
//  Trady
//
//  Created by 이혜주 on 2021/02/07.
//

import Foundation

struct Post {
    static let data: [Post] = [Post(cityId: "",
                                    postId: "0",
                                    writerId: "",
                                    writerName: "hyeju1",
                                    title: "같이 놀러갈 사람 구해요",
                                    contents: "contents1 안녕하세요 같이 놀러가실 분 2명 구합니다. 댓글 남겨주시면 초대해드리겠습니다.",
                                    createDate: 1415637900,
                                    startDate: 0,
                                    endDate: 0),
                               Post(cityId: "",
                                    postId: "1",
                                    writerId: "",
                                    writerName: "hyeju2",
                                    title: "title2",
                                    contents: "contents2",
                                    createDate: 1415637900,
                                    startDate: 0,
                                    endDate: 0),
                               Post(cityId: "",
                                    postId: "2",
                                    writerId: "",
                                    writerName: "hyeju3",
                                    title: "title3",
                                    contents: "contents3",
                                    createDate: 1415637900,
                                    startDate: 0,
                                    endDate: 0),
                               Post(cityId: "",
                                    postId: "3",
                                    writerId: "",
                                    writerName: "hyeju4",
                                    title: "title4",
                                    contents: "contents4",
                                    createDate: 1415637900,
                                    startDate: 0,
                                    endDate: 0)]
    
    let cityId: String
    let postId: String
    let writerId: String
    let writerName: String
    let title: String
    let contents: String
    let createDate: Int
    let startDate: Int
    let endDate: Int
    
     init(cityId: String,
          postId: String,
          writerId: String,
          writerName: String,
          title: String,
          contents: String,
          createDate: Int,
          startDate: Int,
          endDate: Int) {
        self.cityId = cityId
        self.postId = postId
        self.writerId = writerId
        self.writerName = writerName
        self.title = title
        self.contents = contents
        self.createDate = createDate
        self.startDate = startDate
        self.endDate = endDate
    }
    
     init?(info: [String: Any]?) {
        guard let info = info else { return nil }
        
        guard let cityId = info["cityId"] as? String,
            let postId = info["postId"] as? String,
            let uid = info["uid"] as? String,
            let name = info["userName"] as? String,
            let title = info["title"] as? String,
            let contents = info["contents"] as? String,
            let createDate = info["createDate"] as? Int,
            let startDate = info["startDate"] as? Int,
            let endDate = info["endDate"] as? Int else {
                return nil
        }
        
        self.cityId = cityId
        self.postId = postId
        self.writerId = uid
        self.writerName = name
        self.title = title
        self.contents = contents
        self.createDate = createDate
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension Post: Equatable, Hashable {
     static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.postId == rhs.postId
    }
}
