//
//  DoubleRadioButton.swift
//  bootstrap
//
//  Created by Elizabeth Johnston and Thomas Allen on 2/24/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
//- Two Radio Buttons designed for selecting one of two required options.
//


import SwiftUI

//MARK: - SINGLE RADIO BUTTON

struct RadioButton: View {
    //- Single radio button with option to tap to inactivate
    let ifVariable: Bool   //the variable that determines if its checked
    let onTapToActive: ()-> Void    //action when taped to activate
    let onTapToInactive: ()-> Void  //action when taped to inactivate
    
    var body: some View {
        Group{
            if ifVariable {
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                }.onTapGesture {self.onTapToInactive()}
            } else {
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .onTapGesture {self.onTapToActive()}
            }
        }
    }
}



//MARK: - DOUBLE RADIO BUTTONS

struct DoubleRadioButtons: View {
    //- Two Radio Buttons designed for selecting one of two required options.
    /// first option means selected = true, section option means selected = false
    
    //MARK: PROPERTIES
    @Binding var selected: Bool             /// determines which option is selected
    let type: DoubleRadioButtonType
    let title: String
    
    //MARK: BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            
            //- title
            Text(title.uppercased())
                .scaledFont(name: Avenir_Fonts.medium, size: 16)
                .foregroundColor(Color.gray)
            
            //- buttons
            buttons
            
        }
    }
}

//MARK: SUBVIEWS
extension DoubleRadioButtons {
    
    var buttons: some View {
        HStack {
            HStack {
                RadioButton(ifVariable: $selected.wrappedValue, onTapToActive: {self.selected=true;print("true")}, onTapToInactive: {})
                Text(type.trueOption())
                Spacer()
            }
            .frame(width: 90)                   ///**TIP** each button and its label have a width of 90, that can be adjusted here and below for longer or shorter labels
            .padding(.trailing, 30)
            HStack {
                RadioButton(ifVariable: !$selected.wrappedValue, onTapToActive: {self.selected=false;print("false")}, onTapToInactive: {})
                Text(type.falseOption())
                Spacer()
            }
            .frame(width: 90)                   ///**TIP** each button and its label have a width of 90, that can be adjusted here and above for longer or shorter labels
        }
        .scaledFont(name: Avenir_Fonts.medium, size: 16)
        .foregroundColor(Color.blue)
    }
}

//MARK: DOUBLE RADIO BUTTON TYPES

extension DoubleRadioButtons {
    
    enum DoubleRadioButtonType {
        //- type of buttons for DoubleRadioButtons
        /// allows for quick declaration of common types or of custom.
        
        case yesOrNo
        case onOrOff
        case trueOrFalse
        case rightOrLeft
        case custom(option1: String, option2: String)

        
        func trueOption() -> String {
            //- label for option 1 (when selection is true)
            switch self {
                case .yesOrNo:
                    return "Yes"
                case .onOrOff:
                    return "On"
                case .trueOrFalse:
                    return "True"
                case .rightOrLeft:
                    return "Right"
                case let .custom(option1: option1 , option2: _):
                    return option1
            }
        }
        
            
        func falseOption() -> String {
            //- label for option 2 (when selection is false)
            switch self {
                case .yesOrNo:
                    return "No"
                case .onOrOff:
                    return "Off"
                case .trueOrFalse:
                    return "False"
                case .rightOrLeft:
                    return "Left"
                case let .custom(option1: _ , option2: option2):
                    return option2
            }
        }
    }

    
}


//MARK: - MULTI RADIO BUTTONS

struct ListRadioButtons: View {
    //- Two Radio Buttons designed for selecting one of two required options.
    /// first option means selected = true, section option means selected = false
    
    //MARK: PROPERTIES
    @Binding var selected: Int?             /// index of which option is selected
    let optionLabels: [String]
    let selectionRequired: Bool            /// if selection is required, options will not be allowed to be deselected and initial selected will be index 0
    let title: String

    //MARK: INIT
    init(selected: Binding<Int?>, optionLabels: [String], title: String, selectionRequired: Bool){
        self._selected = selected
        self.optionLabels = optionLabels
        self.title = title
        self.selectionRequired = selectionRequired
    }
    
    
    //MARK: BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            
            //- title
            Text(title)
                .scaledFont(name: Avenir_Fonts.medium, size: 16)
                .foregroundColor(Color.gray)
            
            //- buttons
            buttons
            
        }
    }
}

//MARK: SUBVIEWS AND FUNCTIONS
extension ListRadioButtons {
    
    var buttons: some View {
        VStack(alignment: .leading) {
            ForEach(0..<self.optionLabels.count, id: \.self) { i in
                HStack {
                    RadioButton(ifVariable: (self.$selected.wrappedValue == i),
                                onTapToActive: {self.selected = i
                                }, onTapToInactive: {
                                    if !self.selectionRequired {self.selected=nil}  /// only deselects if a selection isn't required
                                })
                    Text(self.optionLabels[i])
                }
            }
        }
        .scaledFont(name: Avenir_Fonts.medium, size: 16)
        .foregroundColor(Color.blue)
    }
    
    
}




