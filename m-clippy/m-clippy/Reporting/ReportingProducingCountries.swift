//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingProducingCountries: View {
    @EnvironmentObject var api: ClippyAPI
    
    var producingKeys:[String] {
        self.api.reportings.ProducingCountries.map { (arg0) -> String in
            let (key, _) = arg0
            return key
        }
    }
    var producingValues:[Int] {
        self.api.reportings.ProducingCountries.map { (arg0) -> Int in
            let (_, value) = arg0
            return value
        }
    }
    
    var body: some View {
        ClippyBox(title: "Producing countries", subTitle:"Clippy shows you where the products had been produced", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("world") ) {
            ForEach(self.producingKeys.indices) { i in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(self.producingKeys[i])").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.producingValues[i])").font(.largeTitle)
                }
            }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
            .foregroundColor(Color.black)
            .background(SettingsView.MigrosColorGreen)
        }

    }
}

struct ReportingProducingCountries_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingProducingCountries().environmentObject(api)
    }
}
