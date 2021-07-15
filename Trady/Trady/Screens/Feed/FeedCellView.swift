//
//  FeedCellView.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import SwiftUI

struct FeedCellView: View {
    var body: some View {
        VStack {
            HStack {
                Image("apple_logo")
                VStack {
                    Text("테스트 아이디")
                    Text("2021.02.03 오후 12 : 30")
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .topLeading)
    }
}

struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellView()
    }
}
