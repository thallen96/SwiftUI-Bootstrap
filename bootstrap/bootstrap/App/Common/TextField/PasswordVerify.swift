//
//  PasswordVerify.swift
//  bootstrap
//
//  Created by Thomas Allen on 10/27/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
//- used to verify if password is correct or when comparing 'new password' entry and 'confirm new password' entry.
//

import SwiftUI

struct PasswordVerifyTextField: View {
    
    //MARK: - PROPERTIES
    //required
    @Binding var password: String
    @Binding var validStatus: Bool?          /// if true, password is marked as valid
    
    // optional customizations
    var placeholder: String? = nil
    var accentColor: Color? = nil
    var allowShowPassword: Bool = true      /// if true, user is allowed to turn on and off show password
    
    // private/state
    @State private var showPassword: Bool = false
    
    
    //MARK: - BODY
    var body: some View {
        HStack {
            
            //- password icon
            Image(systemName: SFSymbols.lock)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(accentColor ?? Color.blue)
                .frame(width: 17, height: 16, alignment: .center)
                .padding(10)

            //- text entry
            /// if showpassword is true, it will be a text entry instead of secureField to allow the user to see entry
            if showPassword {
                TextField(placeholder ?? " ", text: $password)
                    .frame(height: 22)
                    .padding(.vertical, 15)
                    .accentColor(accentColor ?? Color.blue)
            } else {
                SecureField(placeholder ?? " ", text: $password)
                    .frame(height: 22)
                    .padding(.vertical, 15)
                    .accentColor(accentColor ?? Color.blue)
            }

            Spacer()
            
            //- validation icon
            if self.password != ""  && self.validStatus != nil{
                /// if self.validStatus == nil, it defaults to false but that will never matter since we check it in our if statement
                Image(systemName: self.validStatus ?? false ? SFSymbols.checkmark_circle : SFSymbols.xmark_circle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(self.validStatus ?? false ? Color.green : Color.red)
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(10)
            }
            
            //- Show password icon
            if self.allowShowPassword {
                Image(systemName: self.showPassword ? SFSymbols.eye : SFSymbols.eye_slash)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(accentColor ?? Color.blue)
                    .frame(width: 18, height: 16, alignment: .center)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        self.showPassword.toggle()
                    }
            }
        
        }
        .addBorder(accentColor ?? Color.blue, width: 1, cornerRadius: 5)
    }
}


//MARK: - PREVIEW

struct PasswordVerifyTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordVerifyTextField(password: .constant(""), validStatus: .constant(true), placeholder: "Howdy", accentColor: nil)
    }
}
