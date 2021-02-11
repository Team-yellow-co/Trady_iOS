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

                //Googleß
                Button(action: {
                    let form = LoginForm(type: .google)
                    viewModel.login(with: form)
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
                .modifier(LoginViewModifiers.LoginButtonShape(with: .google))
                
                //Apple
                Button(action: {
                    let form = LoginForm(type: .apple)
                    viewModel.login(with: form)
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
                .modifier(LoginViewModifiers.LoginButtonShape(with: .apple))
                
                Button(action: {
                    
                }, label: {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .font(.custom("SpoqaHanSans-Bold", size: 17))
                })
                .modifier(LoginViewModifiers.LoginButtonShape(with: .join))
                
                Button(action: {
                    
                }, label: {
                    
                    Text("트래디 회원이시라면? 로그인")
                        .foregroundColor(.gray)
                        .font(.custom("SpoqaHanSans-Regular", size: 17))
                        .underline(true, color: .gray)
                })
                .modifier(LoginViewModifiers.LoginButtonShape(with: .email))
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
        let previewTestViewModel = LoginViewModel(setting: AppSetting())
        LoginContentView(viewModel: previewTestViewModel)
    }
}
