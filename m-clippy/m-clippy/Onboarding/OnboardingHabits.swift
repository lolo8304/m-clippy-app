//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingHabits<Content: View>: View {
    @EnvironmentObject var api: OnboardingAPI
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

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
            }        }

    }
}

struct OnboardingHabits_Previews: PreviewProvider {
    static var previews: some View {
        let api = OnboardingAPI.Instance
        OnboardingHabits(content: {
            Text("hello")
        }).environmentObject(api)
    }
}
