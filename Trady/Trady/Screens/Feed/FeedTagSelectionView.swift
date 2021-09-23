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
    struct Constant {
        static let itemBorderPaddingInset: EdgeInsets = .init(top: 11,
                                                              leading: 28,
                                                              bottom: 11,
                                                              trailing: 28)
    }
    @ObservedObject private var viewModel: FeedTagSelectionViewModel
    @State var gridLayout = [ GridItem(), GridItem() ]
    
    init(viewModel: FeedTagSelectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(Range(0...viewModel.locationTags.count)) { row in
                    if let currentMasterLocationTag = viewModel.locationTags[safe: row] {
                        VStack {
                            Text(currentMasterLocationTag.locationName)
                                .font(.custom("SpoqaHanSans-Bold", size: 17))
                                .foregroundColor(Color.tradyPurple)
                            
                            FlowLayout(mode: .scrollable,
                                       items: currentMasterLocationTag.subLocations,
                                           itemSpacing: 4) { item in
                                Text(item.locationName)
                                    .font(.system(size: 14, weight: .heavy, design: .default))
                                    .foregroundColor(.black)
                                    .padding(Constant.itemBorderPaddingInset)
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.tradyGray, lineWidth: 1)
                                            )
                                    .onTapGesture(perform: {
                                        viewModel.send(event: FeedEvent.tagSelected(tag: item))
                                    })
                            }
                        }
                    } else {
                        Text("")
                    }
                }
            }
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
            .navigationTitle("태그 선택")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                
            }), trailing: Button(action: {
                viewModel.send(event: FeedEvent.tagCompleted)
            }, label: {
                Text("닫기")
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
