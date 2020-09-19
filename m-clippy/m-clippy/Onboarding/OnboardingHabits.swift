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
        HStack {
            VStack(alignment: .leading) {
                Text("I prefer the following food")
                    .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
                content
            }.padding()
            .foregroundColor(.white)
            .background(SettingsView.MigrosColorCumulus)
        }.padding(18)
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
