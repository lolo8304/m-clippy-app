//
//  ContentView.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

struct SettingsView: View {
    static let MigrosColor:Color = Color(red: 255 / 255, green: 102 / 255, blue: 0 / 255)

    @State var user:User = OnboardingAPI.Instance.currentUser ?? User()
    @State var showingAlert:Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(user.points ?? "0")").font(.largeTitle)
                Text("Cumulus-Points")
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Self.MigrosColor)
                Text("Collection period").font(.caption).padding(0)
                Image("cumulus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(0)
                HStack {
                    HStack {
                        Spacer()
                        Text("Settings")
                        Spacer()
                    }
                    .frame(height:40, alignment: .center)
                    .border(Color.gray, width: 0.3)
                    HStack {
                        Spacer()
                        Image("notification")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(8)
                        Text("Messages")
                        Spacer()
                    }
                    .frame(height:40, alignment: .center)
                    .border(Color.gray, width: 0.3)
                }
                .frame(height:40, alignment: .center)
                .border(Color.gray, width: 0.3)
                List {
                    NavigationLink(destination:
                                    OnboardingSetup(user: self.user)) {
                        Text("m-Clippy Onboarding")
                    }
                    NavigationLink(destination:
                                    OnboardingSetup(user: self.user)) {
                        Text("m-Clippy Tips!")
                    }.disabled(!(self.user.configured ?? true))
                }
                Spacer()
            }
            .navigationBarTitle(Text("Profile: \(user.Name())"))
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Text("Reset")
                    }
                    .accentColor(Self.MigrosColor)
                    .alert(isPresented:$showingAlert) {
                        Alert(title: Text("Are you sure you want to reset?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Reset")) {
                            self.reset()
                        }, secondaryButton: .cancel())
                    }
                }
            )
        }
        .onAppear() {
            self.reset()
        }
    }
    func reset() {
        OnboardingAPI().GetUser { (user) in
            self.user = user
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(showingAlert: false)
            SettingsView(showingAlert: false)
        }
    }
}
