//
//  SearchBar.swift
//  bootstrap
//
//  Created by Thomas Allen on 12/20/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
//- A textfield with a clear button and search icon
//

//TODO: Liz: on its display page, implement the trigger that calls the results to update.

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String   /// the string entered by the user. Should be initialized as an empty string (as such... @State var search: String = "" )
    var placeholder: String?
    var accentColor: Color?
    
    var body: some View {
        Group{
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 17, height: 16, alignment: .center)
                    .foregroundColor(accentColor ?? Color.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                TextField(placeholder ?? " ", text: $searchText)       /// if the variable is an empty string, it shows the placeholder
                    .padding(.vertical, 15)
                    .accentColor(accentColor ?? Color.blue)
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 18)
                    .onTapGesture {
                        self.searchText = ""
                }
            }.background(Color.white)
            .addBorder(accentColor ?? Color.blue, width: 1, cornerRadius: 3)
            .cornerRadius(2)
        }.shadow(color: Color.gray, radius: 1, x: 1, y: 1)  /// **TIP** shadow has to be added to the view around the entire view that declares the background or else everything (text,icon, etc) will all have a shadow
    }
}


struct SearchBar_Previews: PreviewProvider {
        
    static var previews: some View {
        SearchBar(searchText: .constant(""), placeholder: "Hey girl", accentColor: nil)


    }
}
