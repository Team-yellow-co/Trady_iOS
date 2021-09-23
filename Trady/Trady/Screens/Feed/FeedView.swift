//
//  FeedView.swift
//  Trady
//
//  Created by bumslap on 2021/01/25.
//

import SwiftUI
import Combine

struct FeedView: View {
    @ObservedObject private var viewModel: FeedViewModel
    private var subscriptions = Set<AnyCancellable>()
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {

        NavigationView {
            List {
                ForEach(viewModel.feedCellViewModels) { cellVM in
                    FeedCellView(viewModel: cellVM)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                }
            }
            .onAppear {
                           print("ddddd")
                        }
            .listStyle(PlainListStyle())
            .navigationTitle("Trady")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(action: {
                    viewModel.send(event: FeedEvent.showFeedWriteView)
                }) {
                    Image("feed_write")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                }
            )
            .fullScreenCover(isPresented: $viewModel.isFeedWriteShowing, content: {
                FeedWriteView(viewModel: viewModel.feedWriteViewModel)
            })
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        let previewVM = FeedViewModel()
        FeedView(viewModel: previewVM)
    }
}
