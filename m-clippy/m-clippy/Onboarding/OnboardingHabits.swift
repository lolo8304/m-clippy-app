//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingHabits: View {
    @EnvironmentObject var api: ClippyAPI
    
    var body: some View {
        ClippyBox(title: "I prefer the following food", subTitle:"(we will help you choosing the right products)", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("habits-OK") ) {
            Toggle(isOn: $api.user.habits.bio) {
                Text("Bio")
            }
            Toggle(isOn: $api.user.habits.vegetarian) {
                Text("Vegetarian")
            }
            Toggle(isOn: $api.user.habits.vegan) {
                Text("Vegan")
            }
            Toggle(isOn: $api.user.habits.casher) {
                Text("Casher")
            }
            Toggle(isOn: $api.user.habits.halal) {
                Text("Halal")
            }
        }

    }
}

struct OnboardingHabits_Previews: PreviewProvider {
    static var previews: some View {
        let api = ClippyAPI.Instance
        OnboardingHabits().environmentObject(api)
    }
}
