//
//  DynamicButton.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/25/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
//- Examples of dynamic buttons that visually change
/// these are ideal for buttons that rotate through options, buttons that can be on or off, etc..
//

import Foundation
import SwiftUI

//MARK: - VOLUME BUTTON
/// Button that when pressed will rotate through the volume level options and return the shown volumeLevel enum

struct VolumeButton: View {

    @Binding var volumeLevel: VolumeLevel
    
    var body: some View {
        Button(action: {
            self.volumeLevel = self.volumeLevel.nextLevel()
        }){
            Spacer()
            Image(systemName: self.volumeLevel.icon())
                .resizable()
                .frame(width: 20, height: 20)
            Spacer()
        }.primaryStyle
            .frame(width: 40, height: 30)
            .padding(.trailing, 5)
    }
}

//MARK: VOLUME LEVEL ENUM
/// Enum containing the different volume level options and their corresponding icon

extension VolumeButton {
    
    public enum VolumeLevel {
        case mute
        case low
        case medium
        case high

        func icon() -> String {
            //returns the icon name for that volume level
            switch self {
                case .mute:
                    return SFSymbols.speaker_slash
                case .low:
                    return SFSymbols.speaker1
                case .medium:
                    return SFSymbols.speaker2
                case .high:
                    return SFSymbols.speaker3
            }
        }
        
        func nextLevel() -> VolumeLevel {
            //return the next volume level
            /// there is probably a more efficient way to itterate through the volume levels but this works fine
            switch self {
                case .mute:
                    return .low
                case .low:
                    return .medium
                case .medium:
                    return .high
                case .high:
                    return .mute
            }
        }
        
    }
    
    
}



//MARK: - POWER BUTTON
/// Button that when pressed will turn on and off resulting in the variable switching back and forth from true to false

struct PowerButton: View {

    @Binding var power: Bool            /// true = on, false = off
    
    var body: some View {
        Button(action: {
            self.power.toggle()
        }){
            VStack(spacing: 5){
                Image(systemName: SFSymbols.power)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.top, 5)
                    .foregroundColor(self.power ? Color.green : Color.gray)        /// if power is true (on), makes the icon green. if power is false (off), makes the icon white
                Text(self.power ? "On" : "Off")
                    .font(.custom(Avenir_Fonts.medium, size: 10))
                    .foregroundColor(self.power ? Color.green : Color.gray)        /// if power is true (on), makes the text green. if power is false (off), makes the text white (just like icon above)
            }.frame(width: 50, height: 40)
            .padding(10)
            .background(Color.white)
            .cornerRadius(15)
            .overlay(self.power ?
                RoundedRectangle(cornerRadius: 15).stroke(Color(red: 236/255, green: 234/255, blue: 235/255), lineWidth: 1).shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: 3, x: 3, y: 3).clipShape(RoundedRectangle(cornerRadius: 15)).shadow(color: Color.white, radius: 1, x: -1, y: -1).clipShape(RoundedRectangle(cornerRadius: 15)) : nil)    /// this add an inverted shadow overlay if the power is on

            .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: self.power ? 0 : 1, x: self.power ? 0 : 1, y: self.power ? 0 : 1)  /// if the power is off this will add an outward shadow
        }
            .padding(.trailing, 5)
    }
}
