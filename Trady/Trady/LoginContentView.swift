//
//  ContentView.swift
//  Trady
//
//  Created by bumslap on 2021/01/23.
//

import SwiftUI

struct LoginContentView: View {
    var body: some View {
        VStack {
            Text("Trady")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            Button("Google로 로그인") {
                
            }
            Image("google_logo")
        }
        
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
