//
//  ContentView.swift
//  Trady
//
//  Created by bumslap on 2021/01/23.
//

import SwiftUI

struct LoginContentView: View {
    
    let buttonFont: Font = .custom("SpoqaHanSans-Regular", size: 17)
    
    var body: some View {
        VStack {
            Text("Trady")
                .font(.system(size: 55,
                              weight: .heavy,
                              design: .rounded))
                .fontWeight(.black)
            
            Spacer().frame(minWidth: UIScreen.main.bounds.width,
                           maxWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height * 0.15,
                           maxHeight: UIScreen.main.bounds.height * 0.15,
                           alignment: .center)
            
            VStack(alignment: .center, spacing: 10) {

                //Google
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image("google_logo").resizable()
                            .frame(width: 30,
                                   height: 30,
                                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .scaledToFit()
                        Text("Google로 로그인")
                            .foregroundColor(.black)
                            .font(buttonFont)
                    }
                })
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .border(Color("whiteItemBorderColor"),
                        width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(4)
                
                //Apple
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image("apple_logo")
                            .resizable()
                            .frame(width: 30,
                                   height: 30,
                                   alignment: .center)
                            .scaledToFit()
                        Text("Apple로 로그인")
                            .foregroundColor(.white)
                            .font(buttonFont)
                    }
                })
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .background(Color(red: 47/255, green: 47/255, blue: 47/255))
                .cornerRadius(4)
                
                Button(action: {
                    
                }, label: {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .font(.custom("SpoqaHanSans-Bold", size: 17))
                })
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .background(Color(red: 77/255, green: 18/255, blue: 223/255))
                .cornerRadius(4)
                
                Button(action: {
                    
                }, label: {
                    
                    Text("트래디 회원이시라면? 로그인")
                        .foregroundColor(.gray)
                        .font(.custom("SpoqaHanSans-Regular", size: 17))
                        .underline(true, color: .gray)
                })
                .frame(minWidth: 100,
                       idealWidth: 100,
                       maxWidth: .infinity,
                       minHeight: 60,
                       idealHeight: 60,
                       maxHeight: 60,
                       alignment: .center)
                .background(Color(.clear))
                .cornerRadius(4)
            }
            .padding(EdgeInsets(top: 0,
                                leading: 27,
                                bottom: 0,
                                trailing: 27))
        }
        
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
