//
//  ChatView.swift
//  Trady
//
//  Created by bumslap on 2021/01/25.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false,
                   content: {
                    ForEach(0..<10, id:\.self) { index in
                        ChatBubbleView(position: .right,
                                       color: .black) {
                            Text("d")
                        }
                    }
                   })
        }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
