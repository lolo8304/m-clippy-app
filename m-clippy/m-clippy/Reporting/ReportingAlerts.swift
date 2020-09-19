//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct ReportingAlerts: View {
    @EnvironmentObject var api: ClippyAPI
    
    
    var body: some View {
        ClippyBox(title: "Clippy - Alerts", subTitle:"(how products you we alerted to you based on our category)", backColor: SettingsView.MigrosColor, foreColor: Color.white, image: Image("box-question") ) {
            HStack {


            }
        }

    }
}

struct ReportingAlerts_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        ReportingAlerts().environmentObject(api)
    }
}
