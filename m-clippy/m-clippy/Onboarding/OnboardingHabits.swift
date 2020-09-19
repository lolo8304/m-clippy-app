//
//  OnboardingHabits.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingHabits<Content: View>: View {
    @State var habits:Habits = (OnboardingAPI.Instance.currentUser?.habits)!
    let content: Content
    
    init(habits: Habits, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.habits = habits
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("I prefer the following food")
                    .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Toggle(isOn: $habits.bio) {
                    Text("Bio")
                }
                Toggle(isOn: $habits.vegetarian) {
                    Text("Vegetarian")
                }
                Toggle(isOn: $habits.vegan) {
                    Text("Vegan")
                }
                Toggle(isOn: $habits.casher) {
                    Text("Casher")
                }
                Toggle(isOn: $habits.halal) {
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
        let h = Habits()
        OnboardingHabits(habits: h, content: {
            Text("hello")
        })
    }
}
