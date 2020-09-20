//
//  OnboardingSetup.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct Reporting: View {
    @EnvironmentObject var api:ClippyAPI
    
    var body: some View {
        ScrollView {
            ReportingHeader()
            VStack {
                //ReportingSummary().environmentObject(api)
                ReportingLocations().environmentObject(api)
                ReportingSustainability().environmentObject(api)
                ReportingAlerts().environmentObject(api)
                ReportingLifestyle().environmentObject(api)
                ReportingAllergens().environmentObject(api)
                ReportingViolations().environmentObject(api)
                ReportingProducingCountries().environmentObject(api)
                Spacer()
            }
            .padding(EdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0))
            .navigationBarTitle(Text("Clippy Tips \(self.api.user.firstName ?? "-")"))
            .navigationViewStyle(StackNavigationViewStyle())
            /*.navigationBarItems(
                trailing: HStack {
                    Button(action:done, label: { Text("Done") })
                }
            )*/
            Spacer()
        }
    }
    
    func done() {
    
    }
}

struct Reporting_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        Reporting().environmentObject(api)
    }
}
