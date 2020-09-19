//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingLifestyle: View {
    @EnvironmentObject var api: ClippyAPI
    
    
    var body: some View {
        ClippyBox(title: "", subTitle:"Clippy tells you from where your products are orginated", backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("recycling") ) {
            HStack {
                VStack(alignment: .leading) {
                    CardView {
                            ChartLabel("Cost / origin", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)
                    CardView {
                            ChartLabel("Cost / origin", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)

                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                VStack(alignment: .leading) {
                    CardView {
                            ChartLabel("Cost / origin", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)
                    CardView {
                            ChartLabel("Cost / origin", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.RegionalSum, self.api.reportings.NationalSum, self.api.reportings.OutsideSum])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)

                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)


            }
        }

    }
}

struct ReportingLifestyle_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingLifestyle().environmentObject(api)
    }
}
