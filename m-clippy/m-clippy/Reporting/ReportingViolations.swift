//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts



struct ReportingViolations: View {
    @EnvironmentObject var api: ClippyAPI
    
    var violetedProducts:[ProductViolation] {
        return self.api.reportings.list.filter { (v) -> Bool in
            v.HabitsAlert || v.LocationAlert || v.AllergyAlert
        }
    }

    
    var body: some View {
        ClippyBox(title: "Recommandation".t(), subTitle:"Clippy will help you to find alternative products".t(), backColor: SettingsView.MigrosColorWhite, foreColor: Color.black, image: Image("shopping-cart") ) {
            
            ForEach(self.violetedProducts.indices) { i in
                if (i < 8) {
                HStack {
                    ImageView(url: URL(string: self.violetedProducts[i].Original)!, width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("\(self.violetedProducts[i].Name)").font(.headline)
                        Text("\(self.violetedProducts[i].Quantity), \(self.violetedProducts[i].Price.format(f:".2")) CHF").font(.subheadline)
                        
                    }.padding(.leading, 1)
                    Spacer()
                    HStack {
                        if (self.violetedProducts[i].HabitsAlert) {
                            Image("habits-NOK")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        if (self.violetedProducts[i].LocationAlert) {
                            Image("location-NOK")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        if (self.violetedProducts[i].AllergyAlert) {
                            Image("allergy-NOK")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }.font(.largeTitle)
                    
                }.padding(.init(top:4, leading: 0, bottom: 4, trailing: 8))
                }
            }
                
        }

    }
}

struct ReportingViolations_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingViolations().environmentObject(api)
    }
}
