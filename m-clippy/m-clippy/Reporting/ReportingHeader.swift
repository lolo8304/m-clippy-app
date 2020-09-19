//
//  ClippyImageHeader.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct ReportingHeader: View {
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Spacer()
                    Text("1 Week").foregroundColor(.gray)
                    Spacer()
                }
                .frame(height:40, alignment: .center)
                .border(Color.gray, width: 0.3)
                HStack {
                    Image("notification")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(8)
                    Text("1 Month")
                    Spacer()
                }
                .frame(height:40, alignment: .center)
                .background(Color.white)
                .border(Color.gray, width: 0.3)
                HStack {
                    Spacer()
                    Text("This Year").foregroundColor(.gray)
                    Spacer()
                }
                .frame(height:40, alignment: .center)
                .border(Color.gray, width: 0.3)
            }
            .frame(height:40, alignment: .center)
            .border(Color.gray, width: 0.3)
        }.frame(height:100, alignment: .center)
    }
}

struct ReportingHeader_Previews: PreviewProvider {
    static var previews: some View {
        ReportingHeader()
    }
}
