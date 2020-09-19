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

    init(title:String, subTitle:String?, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.subTitle = subTitle
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                if (self.subTitle != nil) {
                    Text(subTitle!)
                        .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                content
            }.padding()
            .foregroundColor(.white)
            .background(SettingsView.MigrosColorCumulus)
        }.padding(18)
    }
}

struct ClippyBox_Previews: PreviewProvider {
    static var previews: some View {
        ClippyBox(title: "title", subTitle:"subtitle") {
            Text("Hello")
        }
    }
}
