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
        ClippyBox(title: "Target".t(), subTitle:"Clippy shows your real consuming habits".t(), backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("target") ) {
            HStack {
                VStack(alignment: .leading) {
                    ClippyBarYesNoBox(title: "Bio".t(),
                                      data: [self.api.reportings.BioCounter, self.api.reportings.NotBioCounter],
                                      text: ["# \(Int(self.api.reportings.BioCounter))", "\(Int(self.api.reportings.NotBioCounter)) "+"Others".t()])

                    ClippyBarYesNoBox(title: "Vegetarian".t(),
                                      data: [self.api.reportings.VegetarianCounter, self.api.reportings.NotVegetarianCounter],
                                      text: ["# \(Int(self.api.reportings.VegetarianCounter))", "\(Int(self.api.reportings.NotVegetarianCounter)) "+"Others".t()])
                    
                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                Spacer()
                VStack(alignment: .leading) {
                    ClippyBarYesNoBox(title: "Vegan".t(),
                                      data: [self.api.reportings.VeganCounter, self.api.reportings.NotVeganCounter],
                                      text: ["# \(Int(self.api.reportings.VeganCounter))", "\(Int(self.api.reportings.NotVeganCounter)) "+"Others".t()])
                    
                    ClippyBarYesNoBox(title: "Allergens".t(),
                                      data: [self.api.reportings.BioCounter, self.api.reportings.NotBioCounter],
                                      text: ["# \(Int(self.api.reportings.BioCounter))", "\(Int(self.api.reportings.NotBioCounter)) "+"Others".t()])
                    
                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                
/*
         
                VStack(alignment: .leading) {
                    CardView {
                            ChartLabel("Vegan", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.VeganCounter, self.api.reportings.NotVeganCounter])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)
                    .frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                    CardView {
                            ChartLabel("Allergens", type: .subTitle)
                            BarChart().padding(10)
                        }
                        .data([self.api.reportings.AllergensCounter, self.api.reportings.NoAllergensCounter])
                        .chartStyle(SettingsView.MigrosMultiStyle)
                        .frame(height: 200)
                        .padding(0)
                    .frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
                }.frame(width: UIScreen.screenWidth / 2 - 2 * 18, alignment: .leading)
*/

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
