//
//  ContentView.swift
//  Trady
//
//  Created by bumslap on 2021/01/23.
//

import SwiftUI

struct LoginContentView: View {
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    @EnvironmentObject var appSetting: AppSetting
    
    @ObservedObject var viewModel: LoginViewModel
    
    let buttonFont: Font = .custom("SpoqaHanSans-Regular", size: 17)
    
    var body: some View {
        VStack {
            Text("T")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.black)
            
            Spacer().frame(minWidth: UIScreen.main.bounds.width,
                           maxWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height * 0.15,
                           maxHeight: UIScreen.main.bounds.height * 0.15,
                           alignment: .center)
            
            VStack(alignment: .center, spacing: 10) {

                //Google
                Button(action: {
                    self.appSetting.isAuthorized = true
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
                .modifier(LoginViewModifiers.LoginButtonShape())
                .background(Color(red: 47/255, green: 47/255, blue: 47/255))
                
                Button(action: {
                    
                }, label: {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .font(.custom("SpoqaHanSans-Bold", size: 17))
                })
                .modifier(LoginViewModifiers.LoginButtonShape())
                .background(Color(red: 77/255, green: 18/255, blue: 223/255))
                
                Button(action: {
                    
                }, label: {
                    
                    Text("트래디 회원이시라면? 로그인")
                        .foregroundColor(.gray)
                        .font(.custom("SpoqaHanSans-Regular", size: 17))
                        .underline(true, color: .gray)
                })
                .modifier(LoginViewModifiers.LoginButtonShape())
                .background(Color(.clear))
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
        let previewTestViewModel = LoginViewModel()
        LoginContentView(viewModel: previewTestViewModel)
    }
}
