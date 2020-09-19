//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingLocations: View {
    @EnvironmentObject var api: OnboardingAPI

    var body: some View {
        ClippyBox(title: "I prefer the following food", subTitle:"(we will help you choosing the right products)", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("locations-OK") ) {
            Toggle(isOn: $api.user.habits.bio) {
                Text("Regional")
            }
            Toggle(isOn: $api.user.habits.vegetarian) {
                Text("Swiss")
            }
            Toggle(isOn: $api.user.habits.vegan) {
                Text("Outside")
            }
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
