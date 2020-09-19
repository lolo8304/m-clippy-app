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
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .padding(.all, 0)
        .navigationBarTitle(Text("Settings \(self.user.Name())"))
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(
            trailing: HStack {
                Button(action:done, label: { Text("Done") })
            }
        )
    }
    
    func done() {
    
    }
}

struct OnboardingSetup_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetup(user: OnboardingAPI.Instance.currentUser ?? User())
    }
}
