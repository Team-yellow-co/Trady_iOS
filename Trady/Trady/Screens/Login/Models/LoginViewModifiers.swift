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
        func body(content: Content) -> some View {
            content
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .cornerRadius(4)
        }
    }
}

