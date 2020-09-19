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
        ClippyBox(title: "Summary", subTitle:"(here you can see how good your are to your objectives)", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("flag") ) {
            HStack {
                VStack {
                    CardView {
                            ChartLabel("Success", type: .subTitle)
                        PieChart().padding(10)
                        }
                        .data([self.score, self.antiScore])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)

                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                VStack {
                    Text("\(self.score)% is based on your last shopping carts.")
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

struct ReportingSummary_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingSummary().environmentObject(api)
    }
}
