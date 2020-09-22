//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts
import Combine

struct ReportingSummary: View {
    @EnvironmentObject var api: ClippyAPI
    
    var antiScore:Double {
        return Double(100 - self.api.reportings.Score)
    }
    var score:Double {
        return Double(self.api.reportings.Score)
    }


    var body: some View {
        ClippyBox(title: "Summary".t(), subTitle:"Clippy tells if you have reached your objectives".t(), backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("flag") ) {
            HStack {
                VStack {
                    CardView {
                        ChartLabel("Success".t(), type: .subTitle)
                        PieChart().padding(10)
                        }
                        .data([self.score, self.antiScore])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)

                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                VStack {
                    Text("%@% is based on your last shopping carts.".tp(self.score))
                    Text("We count violations from your products and your preferences:".t())
                    Text(" ")
                    Text ("- Habits".t())
                    Text ("- Location".t())
                    Text ("- Allergenes".t())
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

struct ReportingSummary_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingSummary().environmentObject(api)
    }
}
