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
    
    
    var body: some View {
        ClippyBox(title: "Origin of products", subTitle:"Clippy tells you from where your products are orginated", backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("location-OK") ) {
            HStack {
                VStack {
                    CardView {
                            ChartLabel("Cost / origin", type: .subTitle)
                            PieChart().padding(10)
                        }
                        .data([self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)

                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                VStack {
                    Text(".asdfasdfdsaf")
                    Text("We count violations from your products and your preferences:")
                    Text(" ")
                    Text ("- Habits")
                    Text ("- Location")
                    Text ("- Allergenes")
                }
                .padding(0).clipped()
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                Spacer()

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
