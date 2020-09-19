//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingLocations: View {
    @EnvironmentObject var api: OnboardingAPI
    @State var isRegional:Bool = true
    @State var isNational:Bool = false
    @State var isOutside:Bool = false
    
    var body: some View {
        ClippyBox(title: "What do you prefer most?", subTitle:"(we will show you from where your consume)", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("location-OK") ) {
            Toggle(isOn: $isRegional) {
                Text("Regional")
            }.onChange(of: true, perform: { value in
                self.api.user.locations.regional = 1
                self.api.user.locations.national = 2
                self.api.user.locations.outside = 3
            })
            Toggle(isOn: $isNational) {
                Text("Swiss")
            }.onChange(of: true, perform: { value in
                self.api.user.locations.regional = 2
                self.api.user.locations.national = 1
                self.api.user.locations.outside = 3
            })
            Toggle(isOn: $isOutside) {
                Text("Outside")
            }.onChange(of: true, perform: { value in
                self.api.user.locations.regional = 2
                self.api.user.locations.national = 3
                self.api.user.locations.outside = 1
            })
            /*VStack {
                Picker(selection: $api.user.locations.exclusion1, label: Text("Choose to exclude")) {
                    ForEach(0 ..< OnboardingAPI.staticExcludedCountries.count) {
                        Text(OnboardingAPI.staticExcludedCountries[$0])
                   }
                }.padding(0)
                    .frame(height: 50)
                    .clipped()
                if ((self.api.user.locations.exclusion1) != nil) {
                    Text("You selected: \(self.api.user.locations.exclusion1!)")
                }
            }*/
            
        }
    }
}

struct OnboardingLocations_Previews: PreviewProvider {
    static var previews: some View {
        let api = OnboardingAPI.Instance
        OnboardingLocations().environmentObject(api)
    }
}
