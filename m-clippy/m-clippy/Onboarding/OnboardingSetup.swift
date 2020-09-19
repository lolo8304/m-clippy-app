//
//  OnboardingSetup.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingSetup: View {
    @State var user:User
    
    var body: some View {
        ScrollView {
            VStack {
                ClippyImageHeader()
                OnboardingHabits(habits: user.habits!, content: {
                        Text("ddd")
                })
                Spacer()
            }
            .padding(.all, 0)
            .navigationBarTitle(Text("Clippy: \(self.user.Name())"))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(
                trailing: HStack {
                    Button(action:done, label: { Text("Done") })
                }
            )
        }
    }
    
    func done() {
    
    }
}

struct OnboardingSetup_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetup(user: OnboardingAPI.Instance.currentUser ?? User())
    }
}
