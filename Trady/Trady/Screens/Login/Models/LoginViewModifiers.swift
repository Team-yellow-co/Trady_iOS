//
//  LoginViewModifiers.swift
//  Trady
//
//  Created by bumslap on 2021/01/28.
//

import Foundation
import SwiftUI

struct LoginViewModifiers {
    struct LoginButtonShape: ViewModifier {
        
        let type: LoginType
        
        init(with type: LoginType) {
            self.type = type
        }
        
        func body(content: Content) -> some View {
            var backgroundColor: Color
            var borderWidth: CGFloat = 0
            switch type {
            case .apple:
                backgroundColor = Color(red: 47/255, green: 47/255, blue: 47/255)
            case .google:
                borderWidth = 1
                backgroundColor = .white
            case .email:
                backgroundColor = .clear
            case .join:
                backgroundColor = Color(red: 77/255, green: 18/255, blue: 223/255)
            }
            
            return content
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .background(backgroundColor)
                .border(Color("whiteItemBorderColor"), width: borderWidth)
                .cornerRadius(4)
        }
    }
}

