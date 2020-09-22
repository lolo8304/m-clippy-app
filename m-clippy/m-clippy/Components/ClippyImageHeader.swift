//
//  ClippyImageHeader.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct ClippyImageHeader: View {
    var body: some View {
        HStack {
            Image("habits-OK")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(0)
            Image("location-OK")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(0)
            Image("allergy-OK")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(0)
        }
        .frame(height:100, alignment: .center)
        Text("Tell Clippy what your preferences are.")
            .padding(.init(top:4, leading: 18, bottom: 4, trailing: 18))
    }
}

struct ClippyImageHeader_Previews: PreviewProvider {
    static var previews: some View {
        ClippyImageHeader()
    }
}
