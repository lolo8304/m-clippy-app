//
//  ClippyBox.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct ClippyBox<Content: View>: View {
    let title: String
    let subTitle: String?
    let content: Content
    let backColor: Color
    let foreColor: Color

    init(title:String, subTitle:String?, backColor: Color = SettingsView.MigrosColor, foreColor: Color = Color.white, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.subTitle = subTitle
        self.backColor = backColor
        self.foreColor = foreColor
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                if (self.subTitle != nil) {
                    Text(subTitle!)
                        .font(.subheadline).fontWeight(.thin)
                }
                Text(" ")
                    .font(.subheadline).fontWeight(.thin)
                content
            }.padding(0)
            .frame(width: UIScreen.screenWidth-4*18, alignment: .topLeading)
        }.padding(18)
        .foregroundColor(self.foreColor)
        .background(self.backColor)
        .border(Color.gray, width: self.backColor == Color.white ? 0.3 : 0.0)

    }
}

struct ClippyBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ClippyBox(title: "title", subTitle:"subtitle", backColor: SettingsView.MigrosColorCumulus) {
                Text("Hello Blue")
            }
            ClippyBox(title: "title", subTitle:"subtitle", backColor: SettingsView.MigrosColor) {
                Text("Hello Orange")
            }
            ClippyBox(title: "title", subTitle:"subtitle", backColor: SettingsView.MigrosColorWhite, foreColor: Color.black) {
                Text("Hello White")
            }
        }
    }
}
