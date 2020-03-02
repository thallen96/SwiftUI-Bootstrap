//
//  DatePickerView.swift
//  bootstrap
//
//  Created by Thomas Allen on 12/4/19.
//  Copyright © 2019 CapTech Consulting. All rights reserved.
//
//- Picker view that allows date selection and screen tap to dismiss
//
/// The date format defined by DatePickerComponents can be date and/or time
///
/// ** NOTE: ** This is a full screen picker. It works best to place the page's views in a ZStack and place the picker last in that ZStack so when the picker it is active, it sits on top of the other views.
///
import SwiftUI

struct DatePickerView: View {
    
    //MARK: PROPERTIES
    @Binding var selection: Date            /// returns the item selected by user
    @Binding var show: Bool                 /// determines when picker is to be displayed or not
    var components: DatePickerComponents?   /// what type of date to be selected (date and/or time). defaults to .date
    
    @State var date: Date       /// when initializing, set this as the wrapped value of the variable that is set by selection. This will allow the user to be shown the most recetly selected date when the picker first opens.
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
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
                withAnimation {
                    self.show = false
                }
            }
            
            //- picker view
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    DatePicker("", selection: self.$date, displayedComponents: components ?? .date)
                    .padding(.horizontal, 20)
                    .labelsHidden() /// this hides where the title would be. since we didn't define one it was leaving uneven white space on the left.
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
                self.selection = self.date
                withAnimation {
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

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(selection: .constant(Date()), show: .constant(true), date: Date())
    }
}
