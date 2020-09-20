//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingAllergens: View {
    @EnvironmentObject var api: ClippyAPI
    
    var allergenKeys:[String] {
        self.api.reportings.allergens.map { (arg0) -> String in
            let (key, _) = arg0
            return key
        }
    }
    var allergenValues:[Int] {
        self.api.reportings.allergens.map { (arg0) -> Int in
            let (_, value) = arg0
            return value
        }
    }
    var allergenTexts:[String] {
        self.api.reportings.allergens.map { (arg0) -> String in
            let (key, _) = arg0
            return self.api.staticAllergenes.list.first { (allergen) -> Bool in
                allergen.Code == key
            }?.Text ?? "-"
        }
    }
    
    var body: some View {
        ClippyBox(title: "Allergenes", subTitle:"Clippy warns you about allergens in your products you bought", backColor: SettingsView.MigrosColorGreen, foreColor: Color.black, image: Image("allergy-NOK") ) {
            ForEach(self.allergenTexts.indices) { i in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(self.allergenTexts[i])").font(.headline)
                    }.padding(.leading, 1)
                    Spacer()
                    Text("\(self.allergenValues[i])").font(.largeTitle)
                }
            }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
            .foregroundColor(Color.black)
            .background(SettingsView.MigrosColorGreen)
        }

    }
}

struct ReportingAllergens_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingAllergens().environmentObject(api)
    }
}
