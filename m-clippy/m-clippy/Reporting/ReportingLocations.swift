//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingLocations: View {
    @EnvironmentObject var api: ClippyAPI
    
    //self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum
    var body: some View {
        ClippyBox(title: "Origin of products", subTitle:"Clippy tells you where you spend most of your money", backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("location-OK") ) {
            VStack {
                HStack {
                    Image("zurich")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Regional").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(Int(self.api.reportings.RegionalSum)) CHF").font(.title)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("switzerland")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Swiss product").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(Int(self.api.reportings.NationalSum)) CHF").font(.title)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("world")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Outside of Switzerland").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(Int(self.api.reportings.OutsideSum)) CHF").font(.title)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
            }
        }

    }
}

struct ReportingLocations_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingLocations().environmentObject(api)
    }
}
