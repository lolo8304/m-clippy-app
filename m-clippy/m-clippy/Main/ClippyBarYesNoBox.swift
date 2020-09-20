//
//  ClippyBox.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ClippyBarYesNoBox: View {
    let title: String
    let data: [Double]
    let text: [String]
    
    init(title:String, data: [Double], text: [String]) {
        self.title = title
        self.data = data
        self.text = text
    }

    var body: some View {
        VStack {
            CardView {
                ChartLabel(self.title, type: .subTitle)
                    BarChart().padding(10)
                }
            .data(self.data)
                .chartStyle(SettingsView.MigrosMultiStyle)
                .frame(height: 200)
                .padding(0)
            HStack {
                HStack {
                    Spacer()
                    Text(self.text[0])
                    Spacer()
                }
                .frame(height:40, alignment: .center)
                HStack {
                    Spacer()
                    Text(self.text[1])
                    Spacer()
                }
                .frame(height:40, alignment: .center)
            }
            .font(.caption2)
            .frame(height:40, alignment: .center)
            .padding(0).clipped()
            .fixedSize(horizontal: false, vertical: true)
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
            .border(Color.gray, width: 0.3)
            Text(" ")
        }
        .frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
    }
}

struct ClippyBarYesNoBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ClippyBarYesNoBox(title: "Bio",
                              data: [10.0, 15.0], text: ["Left 2345345 snf mtro", "Right"])
        }
    }
}
