//
//  Picker.swift
//  bootstrap
//
//  Created by Elizabeth Johnston and Thomas Allen on 2/28/19.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
// - A single variable picker with custom list items made of Strings
//
/// this is can also be adjusted so the options and selection are of a different data type
///
/// ** NOTE: ** This is a full screen picker. It works best to place the page's views in a ZStack and place the picker last in that ZStack so when the picker it is active, it sits on top of the other views.
///

import SwiftUI

struct BasicPickerView: View {
    
    //MARK: PROPERTIES
    @Binding var selection: String      /// returns the item selected by user
    @Binding var show: Bool             /// determines when picker is to be displayed or not
    var options: [String]               /// the options displayed to the user
    var placeholder: String?
    
    @State private var index = 0
    
    
    //MARK: BODY

    var body: some View {
        ZStack {
            
            //- tap out background
            ///this allows the user to tap the screen outside of the picker to dismiss it
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.1))
            .edgesIgnoringSafeArea(.all)
            .opacity(self.show ? 1.0 : 0.0)
            .animation(Animation.easeInOut.delay(0.25))
            .onTapGesture {
                self.show = false
            }
            
            //- picker view
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    Picker(placeholder ?? "", selection: $index) {
                        ForEach(0 ..< options.count) {
                            Text(self.options[$0]).tag($0)
                        }
                    }
                    .padding(.horizontal, 20)
                    .labelsHidden()
                    footer
                }
                .background(Color.white)
                .cornerRadius(5)
                .frame(minHeight: 0, idealHeight: 250, maxHeight: 300)
                .shadow(radius: 1)
                .animation(Animation.easeInOut)
            }
        }
    }
    
    
    //MARK: SUBVIEWS
    
    var footer: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    self.selection = self.options[self.index]
                    self.show = false
                }
            }) {
                Text("DONE")
                    .fakeButtonStylePrimary         ///custom Text extension defined in Style+Extensions.swift
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}



//MARK: - PREVIEW

struct BasicPickerView_Previews: PreviewProvider {
    static var previews: some View {
        BasicPickerView(selection: .constant("none"), show: .constant(true), options: ["a","b","c","d","e","f"], placeholder: "Pick a letter")
    }
}
