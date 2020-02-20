//
//  TitleViews.swift
//  bootstrap
//
//  Created by Elizabeth Johnston on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//
//  -- Custom navgiation bars
//

import Foundation
import SwiftUI





// MARK: - NAVIGATION BAR VIEW

struct NavigationBarView: View{
    // Navigation bar with optional title and NavButtons.
    
    //MARK: PROPERTIES
    var title: String?
    var leftButton: NavButton?
    var rightButton: NavButton?
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    
    
    //MARK: BODY
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor ?? Color.white)                  /// ** TIP ** change nav  bar background color here
            ZStack {
                // Title
                HStack {
                    Spacer()
                    Text(title ?? "")
                        .font(.custom(Avenir_Fonts.heavy, size: 16))
                        .foregroundColor(titleColor ?? Color.blue)
                        .frame(width: 179, height: 18, alignment: .center)
                    Spacer()
                }
                // Left corner
                HStack {
                    leftButton?.view()
                    Spacer()
                }
                // Right corner: profile picture
                HStack {
                    Spacer()
                    rightButton?.view()
                }
            }.frame(height: 65)
            .padding(.horizontal, 20)
        }.padding(.bottom, 10)
    }
}



// MARK: - NAVIGATION BUTTONS

enum NavButton {
    //buttons that can be added to a navigation bar
    
    case back(tapFunction: ()->Void, color: UIColor?)
    case image(imageName: String, tapFunction: ()->Void)
    case text(text: String, tapFunction: ()->Void, color: UIColor?)
    case profilePic(imageName: String?, caption: String?, tapFunction: ()->Void)
    
    func view() -> some View {
        //- returns the view associated with the proper button
        switch self {
        
        case let .back(tapFunction: tapFunction, color: color):
            return
                    HStack {
                        Image(SFSymbols.chevron_left)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 7, height: 13, alignment: .leading)
                            .padding(.trailing, 6)
                            .foregroundColor(color ?? .blue)
                        Text("BACK")
                            .scaledFont(name: Avenir_Fonts.medium, size: 13)
                            .frame(width: 35, height: 18, alignment: .leading)
                            .foregroundColor(color ?? .blue)
                    }.onTapGesture {
                        tapFunction()
                    }
                    .foregroundColor(color ?? .blue)
            
        case let .image(imageName: imageName, tapFunction: tapFunction):
            return
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 58.93, height: 27.79, alignment: .leading)
                    .onTapGesture {
                        tapFunction()
                    }
        
        case let .text(text: text, tapFunction: tapFunction, color: color):
            return
                Text(text)
                    .scaledFont(name: Avenir_Fonts.medium, size: 13)
                    .frame(width: 35, height: 18, alignment: .leading)
                    .foregroundColor(color ?? .blue)
                    .onTapGesture {
                        tapFunction()
                    }
            
        case let .profilePic(imageName: imageName, caption: caption, tapFunction: tapFunction):
            return
                VStack {
                    ProfilePicture(color: Color.level1, borderWidth: 1, picURL: imageName)
                        .TapGesture{
                            tapFunction
                        }
                        .frame(width: 38, height: 38, alignment: .top)
                    
                    Text(caption ?? "")
                        .caption
                        .frame(width: 38, height: 11, alignment: .center)
                }
                .padding()
            
        }
    }
   
    
}




//// MARK: - TITLE VIEW
//
//struct TitleView: View{
//    // Navigation bar containing title, logo and profile picture with tap action
//    /// Profile picture action is ideal for navigating to/presenting profile details, opening sidebar, etc..
//
//    //MARK: PROPERTIES
//    var title: String
//    var profilePicURL: URL?
//    var profilePicAction: () -> Void            ///action performed when profile image is tapped
//    var profileCaption: String?                 /// caption shown under profile picture (ideal for users' names)
//    var logoImage: String
//
//
//    //MARK: BODY
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.white)                  /// ** TIP ** change nav  bar background color here
//            ZStack {
//                // Title
//                HStack {
//                    Spacer()
//                    Text(title)
//                        .primaryHeaderStyle         /// custom font defined in Style+Extensions.swift
//                        .frame(width: 179, height: 18, alignment: .center)
//                    Spacer()
//                }
//                // Left corner: logo
//                HStack {
//                    Image(logoImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 58.93, height: 27.79, alignment: .leading)
//                    Spacer()
//                }
//                // Right corner: profile picture
//                HStack {
//                    Spacer()
//                    profileImage
//                }
//            }.frame(height: 65)
//            .padding(.horizontal, 20)
//        }.padding(.bottom, 10)
//    }
//}
//
////MARK: TITLE VIEW SUBVIEWS
//
//extension TitleView {
//
//    var profileImage: some View {
//        VStack {
//            //TODO: FINISH COMMENT
//            Image(logoImage)
//            //ProfilePicture(color: Color.level1, borderWidth: 1, picURL: profilePicURL)  /// custom image format found in
//                .gesture(
//                    TapGesture()
//                        .onEnded{ _ in
//                            self.profilePicAction()
//                })
//                .frame(width: 38, height: 38, alignment: .top)
//
//            Text(profileCaption ?? "")
//                .caption
//                .frame(width: 38, height: 11, alignment: .center)
//        }
//        .padding()
//    }
//
//}
//
//
//// MARK: - BASIC TITLE VIEW
//
//struct BasicTitleView: View{
//    // Navigation bar containing title and logo with tap action
//    /// Logo action is ideal for navigating to/presenting organization information, navigating to home view, etc..
//
//    //MARK: PROPERTIES
//    var title: String
//    var logoAction: ()->Void                ///action performed when logo is tapped
//    var logoImage: String
//
//
//    //MARK: BODY
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.white)              /// ** TIP ** change nav  bar background color here
//            ZStack {
//                // Title
//                HStack {
//                    Spacer()
//                    Text(title)
//                        .primaryHeaderStyle             /// custom font defined in Style+Extensions.swift
//                        .frame(width: 179, height: 18, alignment: .center)
//                    Spacer()
//                }
//                // Left corner - logo
//                HStack {
//                    Image(logoImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 58.93, height: 27.79, alignment: .leading)
//                        .onTapGesture {
//                            self.logoAction()
//                    }
//                    Spacer()
//                }
//            }.frame(height: 65)
//            .padding(.horizontal, 20)
//        }.padding(.bottom, 10)
//    }
//}
//
//// MARK: - BACK TITLE VIEW
//
//struct BackTitleView: View {
//    // Navigation bar containing title and back button with tap action
//    /// back action is normally for returning to previous view
//
//    //MARK: PROPERTIES
//    var title: String
//    var backAction: ()->Void                ///action performed when back button is tapped
//
//    //MARK: BODY
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.white)              /// ** TIP ** change nav  bar background color here
//            VStack {
//                Spacer()
//                ZStack {
//                    // Title
//                    HStack {
//                        Spacer()
//                        Text(title)
//                            .primaryHeaderStyle             /// custom font defined in Style+Extensions.swift
//                            .frame(width: 180, height: 18, alignment: .center)
//                        Spacer()
//                    }
//                    // Left corner - back button
//                    HStack {
//                        backButton
//                        Spacer()
//
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//            .padding(.bottom, 20)
//        }
//    }
//}
//
////MARK: BACK TITLE SUBVIEWS
//
//extension BackTitleView {
//    var backButton: some View {
//        HStack {
//            Image(SFSymbols.chevron_left)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 7, height: 13, alignment: .leading)
//                .padding(.trailing, 6)
//                .foregroundColor(.blue)                         /// ** TIP ** change chevron color here
//            Text("BACK")
//                .scaledFont(name: Avenir_Fonts.medium, size: 13)
//                .frame(width: 35, height: 18, alignment: .leading)
//                .foregroundColor(.blue)                         /// ** TIP ** change back text color here
//        }.onTapGesture {
//            self.backAction()
//        }
//        .foregroundColor(.blue)
//    }
//}
//
//
//// MARK: - BACK AND OPTION TITLE VIEW
//
//struct BackAndOptionTitleView: View {
//    // Navigation bar containing title, back button with tap action and text button
//    /// back action is normally for returning to previous view
//
//    var title: String
//    var backAction: ()->Void                ///action performed when back button is tapped
//    var optionAction: ()->Void              ///action performed when back button is tapped
//    var option: String
//
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.white)                  /// ** TIP ** change nav bar color here
//            VStack {
//                Spacer()
//                ZStack {
//                    HStack {
//                        Spacer()
//                        Text(title)
//                            .primaryHeaderStyle             /// custom font defined in Style+Extensions.swift
//                            .frame(width: 180, height: 18, alignment: .center)
//                        Spacer()
//                    }
//                    HStack {
//                        backButton
//                        Spacer()
//                        editButton
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//            .padding(.bottom, 20)
//        }
//    }
//
//    var backButton: some View {
//        HStack {
//            Image(General_Icons.chevron_left)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 7, height: 13, alignment: .leading)
//                .padding(.trailing, 6)
//            Text("BACK")
//                .scaledFont(name: CustomFont.OpenSansRegular, size: 13)
//                .frame(width: 35, height: 18, alignment: .leading)
//        }.onTapGesture {
//            withAnimation {
//                self.backAction()
//            }
//        }
//        .foregroundColor(.level1)
//    }
//
//    var editButton: some View {
//        HStack {
//            if option != "BRIEF" {Spacer()}
//            Text(option.uppercased())
//                .scaledFont(name: CustomFont.OpenSansRegular, size: 13)
//                .frame(width: 60, height: 18, alignment: .trailing)
////                .padding(.trailing, 6)
////                .frame(width: 35, height: 18, alignment: .trailing)
//            if option == "CLOSE" { close }
//            else if option == "END" { end }
//            else { editImage }
//        }.onTapGesture {
//            self.editAction()
//        }
//        .foregroundColor(.level1)
//    }
//
//    var editImage: some View {
//        Image(General_Icons.edit_blue)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 7, height: 13, alignment: .leading)
//            .padding(.trailing, 6)
//    }
//
//    var close: some View {
//        Image(systemName: "xmark")
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 8, height: 12, alignment: .leading)
//            .padding(.trailing, 6)
//    }
//
//    var end: some View {
//        Image(General_Icons.stop_circle_blue)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 7, height: 13, alignment: .leading)
//            .padding(.trailing, 6)
//    }
//}
//
//
//// MARK: - Navigation bar title with back and end buttons for Active Session Screens
//struct BackAndEndView: View {
//
//    var title: String
//    var backAction: ()->Void
//    var endAction: ()->Void
//    //    var homeAction: ()->Void
//
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.white)
//            VStack {
//                Spacer()
//                ZStack {
//                    HStack {
//                        Spacer()
//                        Text(title)
//                            .primaryHeaderStyle
//                            .frame(width: 179, height: 18, alignment: .center)
//                        Spacer()
//                    }
//                    HStack {
//                        backButton
//                        Spacer()
//                        endButton
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//            .padding(.bottom, 20)
//        }
//    }
//
//    var backButton: some View {
//        HStack {
//            Image(General_Icons.chevron_left)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 7, height: 13, alignment: .leading)
//                .padding(.trailing, 6)
//            Text("BACK")
//                .scaledFont(name: CustomFont.OpenSansRegular, size: 13)
//                .frame(width: 35, height: 18, alignment: .leading)
//        }.onTapGesture {
//            withAnimation {
//                self.backAction()
//            }
//        }
//        .foregroundColor(.level1)
//    }
//
//    var endButton: some View {
//        HStack {
//            Text("END")
//                .scaledFont(name: CustomFont.OpenSansRegular, size: 13)
//                .frame(width: 35, height: 18, alignment: .trailing)
//            Image(General_Icons.stop_circle_blue)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 7, height: 13, alignment: .leading)
//                .padding(.trailing, 6)
//        }.onTapGesture {
//            self.endAction()
//        }
//        .foregroundColor(.level1)
//    }
//}
//
//
//
//// MARK: - Navigation bar title with back button
//struct SheetView: View {
//    @Environment(\.presentationMode) var presentationMode
//    var title: String
////    var action: ()->Void
//    //    var homeAction: ()->Void
//
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.white)
//            VStack {
//                Spacer()
//                ZStack {
//                    HStack {
//                        Spacer()
//                        Text(title)
//                            .primaryHeaderStyle
//                            .frame(width: 179, height: 18, alignment: .center)
//                        Spacer()
//                    }
//                    HStack {
//                        backButton
//                        Spacer()
//
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//            .padding(.bottom, 20)
//        }
//    }
//
//    var backButton: some View {
//        HStack {
//            Image(General_Icons.chevron_left)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 7, height: 13, alignment: .leading)
//                .padding(.trailing, 6)
//            Text("BACK")
//                .scaledFont(name: CustomFont.OpenSansRegular, size: 13)
//                .frame(width: 35, height: 18, alignment: .leading)
//        }.onTapGesture {
//            self.presentationMode.wrappedValue.dismiss()
//        }
//        .foregroundColor(.level1)
//    }
//}
//
//
//




