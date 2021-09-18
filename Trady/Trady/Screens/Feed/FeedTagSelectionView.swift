//
//  FeedTagSelectionView.swift
//  Trady
//
//  Created by USER on 2021/09/19.
//

import Foundation
import SwiftUIFlowLayout
import SwiftUI

struct FeedTagSelectionView: View {
    @ObservedObject private var viewModel: FeedTagSelectionViewModel
    @State var gridLayout = [ GridItem(), GridItem() ]
    init(viewModel: FeedTagSelectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ForEach(Range(0...viewModel.locationTags.count)) { row in
                if let currentMasterLocationTag = viewModel.locationTags[safe: row] {
                    Text(currentMasterLocationTag.locationName)
                    FlowLayout(mode: .scrollable,
                               items: currentMasterLocationTag.subLocations,
                                   itemSpacing: 4) {
                        Text($0.locationName)
                            .font(.system(size: 14, weight: .heavy, design: .default))
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle()
                                            .border(Color.gray)
                                            .foregroundColor(Color.white))
                        }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:   10))
            .navigationTitle("태그 선택")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("X")
            }), trailing: Button(action: {
                //let
                //viewModel.send(event: event)
            }, label: {
                Text("완료")
            }))
        }
    }
}

struct FeedTagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let testVM = FeedTagSelectionViewModel()
        FeedTagSelectionView(viewModel: testVM)
    }
}
