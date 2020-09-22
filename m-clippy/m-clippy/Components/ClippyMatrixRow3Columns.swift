//
//  ClippyMatrixRow.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 20.09.20.
//

import SwiftUI
struct ClippyMatrixRow3Columns<Content: View, Data: View>: View {
    let image: String
    let isUrl: Bool
    let content: Content
    let data: Data
    
    init(image:String, isUrl:Bool , @ViewBuilder content: () -> Content, @ViewBuilder data: () -> Data) {
        self.image = image
        self.isUrl = isUrl
        self.content = content()
        self.data = data()
    }

    var body: some View {
        HStack {
            if (!self.isUrl) {
                Image(self.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            } else {
                ImageView(url: URL(string: image)!, width: 50, height: 50)
            }
            VStack(alignment: .leading) {
                content
            }.padding(.leading, 1)
            Spacer()
            data
                .font(.title)
        }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))    }
}

struct ClippyMatrixRow3Columns_Previews: PreviewProvider {
    static var previews: some View {
        ClippyMatrixRow3Columns(image: "car", isUrl:false, content: {
            Text("Product abc")
        }, data: {
            Text("100 CHF")
        })
    }
}
