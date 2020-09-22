//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingSustainability: View {
    @EnvironmentObject var api: ClippyAPI
    
    
    var body: some View {
        ClippyBox(title: "Sustainability".t(), subTitle:"Clippy tells CO2 equivalent to".t(), backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("recycling") ) {
            VStack {
                HStack {
                    Image("cars")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("km you could drive".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.PlanesKm)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("planes")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Miles you could fly".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.CarKm)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("countries")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("No of countries from your products".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.CountriesCounter)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
            }
        }

    }
}

struct ReportingSustainability_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingSustainability().environmentObject(api)
    }
}
