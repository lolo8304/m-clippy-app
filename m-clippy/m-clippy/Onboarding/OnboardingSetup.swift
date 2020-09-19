//
//  OnboardingSetup.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct OnboardingSetup: View {
    @EnvironmentObject var api:OnboardingAPI
    
    var body: some View {
        ScrollView {
            VStack {
                ClippyImageHeader()
                OnboardingHabits(content: {
                        Text("ddd")
                }).environmentObject(api)
                Spacer()
            }
            .padding(.all, 0)
            .navigationBarTitle(Text("Clippy: \(self.api.user.Name())"))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(
                trailing: HStack {
                    Button(action:done, label: { Text("Done") })
                }
            )
        }.background(Color.green)
    }
    
    func done() {
    
    }
}

struct OnboardingSetup_Previews: PreviewProvider {
    static var previews: some View {
        let api = OnboardingAPI.Instance
        OnboardingSetup().environmentObject(api)
    }
}
