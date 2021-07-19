//
//  FeedWriteView.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import SwiftUI

struct FeedWriteView: View {
    private var viewModel: FeedWriteViewModel
    
    init(viewModel: FeedWriteViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text("Hello, World!")
    }
}

struct FeedWriteView_Previews: PreviewProvider {
    static var previews: some View {
        let testVM = FeedWriteViewModel()
        FeedWriteView(viewModel: testVM)
    }
}
