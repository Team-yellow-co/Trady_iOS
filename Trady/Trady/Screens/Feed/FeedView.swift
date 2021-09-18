//
//  FeedView.swift
//  Trady
//
//  Created by bumslap on 2021/01/25.
//

import SwiftUI
import Combine

struct FeedView: View {
    private var viewModel: FeedViewModel
    private var subscriptions = Set<AnyCancellable>()
    @State private var isFeedWriteShowing = false
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
            .listStyle(PlainListStyle())
            .navigationTitle("Trady")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(action: {
                    isFeedWriteShowing = true
                }) {
                    Image("feed_write")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                }
            )
            .fullScreenCover(isPresented: $isFeedWriteShowing, content: {
                FeedWriteView(viewModel: viewModel.feedWriteViewModel)
            })
        }
        .onAppear(perform: {
            viewModel.send(event: FeedEvent.onAppear)
        })
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        let previewVM = FeedViewModel()
        FeedView(viewModel: previewVM)
    }
}
