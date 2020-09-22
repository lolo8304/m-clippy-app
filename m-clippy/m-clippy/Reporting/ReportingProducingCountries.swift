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
        self.api.reportings.ProducingCountries.sorted(by: { (arg0, arg1) -> Bool in
            let (key0, value0) = arg0
            let (key1, value1) = arg1
            return value0 > value1 || (value0 == value1 && key0 < key1)
        }).map { (arg2) -> String in
            let (key, _) = arg2
            return key
        }
    }
    var producingValues:[Int] {
        self.api.reportings.ProducingCountries.sorted(by: { (arg0, arg1) -> Bool in
            let (key0, value0) = arg0
            let (key1, value1) = arg1
            return value0 > value1 || (value0 == value1 && key0 < key1)
        }).map { (arg0) -> Int in
            let (_, value) = arg0
            return value
        }
    }
    
    var body: some View {
        ClippyBox(title: "Producing countries".t(), subTitle:"Clippy shows you where the products have been produced".t(), backColor: SettingsView.MigrosColor, foreColor: Color.white, image: Image("world") ) {
            ForEach(self.producingKeys.indices) { i in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(self.producingKeys[i])").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.producingValues[i])").font(.largeTitle)
                }
            }.padding(.init(top:0, leading: 0, bottom: 0, trailing: 8))
            .foregroundColor(Color.white)
            .background(SettingsView.MigrosColor)
        }

    }
}

struct ReportingProducingCountries_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingProducingCountries().environmentObject(api)
    }
}
