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
        ClippyBox(title: "I prefer food habits", subTitle:"Clippy will assist you choosing the right products", backColor: SettingsView.MigrosColorCumulus, foreColor: Color.white, image: Image("habits-OK") ) {
            Toggle(isOn: $api.user.habits.bio) {
                Text("Bio")
            }
            Toggle(isOn: $api.user.habits.vegetarian) {
                Text("Vegetarian")
            }
            Toggle(isOn: $api.user.habits.vegan) {
                Text("Vegan")
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
