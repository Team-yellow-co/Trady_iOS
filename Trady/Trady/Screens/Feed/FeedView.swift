//
//  FeedView.swift
//  Trady
//
//  Created by bumslap on 2021/01/25.
//

import SwiftUI

struct FeedView: View {
    private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.feedCellViewModels) { cellVM in
                    FeedCellView()
                }
            }
            .navigationTitle("Trady")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        let previewVM = FeedViewModel()
        FeedView(viewModel: previewVM)
    }
}
