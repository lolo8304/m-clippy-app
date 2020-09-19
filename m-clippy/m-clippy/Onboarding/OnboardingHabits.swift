//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingHabits<Content: View>: View {
    @ObservedObject var user: User
    let content: Content
    
    init(user: User, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.user = user
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("I prefer the following food")
                    .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Toggle(isOn: $user.habits.bio) {
                    Text("Bio")
                }
                Toggle(isOn: $user.habits.vegetarian) {
                    Text("Vegetarian")
                }
                Toggle(isOn: $user.habits.vegan) {
                    Text("Vegan")
                }
                Toggle(isOn: $user.habits.casher) {
                    Text("Casher")
                }
                Toggle(isOn: $user.habits.halal) {
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
        let u = OnboardingAPI.DemoUser()
        OnboardingHabits(user: u, content: {
            Text("hello")
        })
    }
}
