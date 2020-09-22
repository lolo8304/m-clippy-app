//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingAlerts: View {
    @EnvironmentObject var api: ClippyAPI
    
    
    var body: some View {
        ClippyBox(title: "Alerts".t(), subTitle:"Clippy has alerted you so many times".t(), backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("alerts") ) {
            VStack {                
                HStack {
                    Image("habits-NOK")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Eating habits and behaviors".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.HabitsCounter)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("location-NOK")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Origin of products".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.LocationCounter)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                HStack {
                    Image("allergy-NOK")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Allergenes in products".t()).font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.api.reportings.AllergyCounter)").font(.largeTitle)
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
            }
        }

    }
}

struct ReportingAlerts_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingAlerts().environmentObject(api)
    }
}
