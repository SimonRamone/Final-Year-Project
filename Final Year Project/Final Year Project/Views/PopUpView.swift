//
//  PopUpView.swift
//  Final Year Project
//
//  Created by Simonas Ramonas on 17/02/2022.
//

import SwiftUI

struct PopUpView: View {
    @Binding var isPresented: Bool
    
    var title: String
    var message: String
    var buttonText: String
    
    var body: some View {
        if isPresented {
            Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0) {
                if !title.isEmpty {
                    Text(title)
                        .padding(.top, 40)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
                    .foregroundColor(.black)
                
                Button(action: {
                    isPresented = false
                }, label: {
                    Text(buttonText)
                        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .foregroundColor(.white)
                        .background(.gray.opacity(0.6))
                        .cornerRadius(45)
                        .font(.headline)
                }).padding()
            }
            .frame(maxWidth: 300, alignment: .init(horizontal: .center, vertical: .center))
            .background(.white)
            .cornerRadius(45)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(isPresented: .constant(true), title: "Title", message: "messagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessage", buttonText: "Got it!")
    }
}
