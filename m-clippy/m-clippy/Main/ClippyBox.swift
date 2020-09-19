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
    let image: Image

    init(title:String, subTitle:String?, backColor: Color = SettingsView.MigrosColor, foreColor: Color = Color.white, image:Image = Image("box-profil") , @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.subTitle = subTitle
        self.backColor = backColor
        self.foreColor = foreColor
        self.image = image
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Text(title)
                            .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(width: UIScreen.screenWidth-4*18-32, alignment: .leading)
                        if (self.subTitle != nil) {
                            Text(subTitle!)
                                .font(.subheadline).fontWeight(.thin)
                                .frame(width: UIScreen.screenWidth-4*18-32, alignment: .leading)
                        }
                    }.padding(0)
                    .frame(width: UIScreen.screenWidth-4*18-50, alignment: .leading)
                    Spacer()
                    image
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                }.padding(0)
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
            ClippyBox(title: "I am a very long title and want to see what happens", subTitle:"subtitle", backColor: SettingsView.MigrosColorCumulus) {
                Text("Hello Blue")
            }
            ClippyBox(title: "title a sort one", subTitle:"subtitle - and a subtitlesubtitle - and a subtitlesubtitle - and a subtitlesubtitle - and a subtitle", backColor: SettingsView.MigrosColor) {
                Text("Hello Orange")
            }
            ClippyBox(title: "title", subTitle:"", backColor: SettingsView.MigrosColorWhite, foreColor: Color.black) {
                Text("Hello White")
            }
        }
    }
}
