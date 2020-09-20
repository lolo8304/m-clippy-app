//
//  ContentView.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI
import SwiftUICharts

struct SettingsView: View {
    static let MigrosColor:Color = Color(red: 255 / 255, green: 102 / 255, blue: 3   / 255)
    static let MigrosColorCumulus:Color = Color(red: 0 / 255, green: 61 / 255, blue: 141 / 255)
    static let MigrosColorGreen:Color = Color(red: 121 / 255, green: 188 / 255, blue: 56 / 255)
    static let MigrosColorWhite:Color = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let MigrosColorGray:Color = Color(red: 236 / 255, green: 236 / 255, blue: 236 / 255)

    static let MigrosMultiStyle = ChartStyle(backgroundColor: Color.green.opacity(0.2),
                                    foregroundColor:
                                        [ColorGradient(.green, .blue),
                                         ColorGradient(.orange, .red),
                                         ColorGradient(.green, .yellow),
                                         ColorGradient(.red, .purple),
                                         ColorGradient(.yellow, .orange),
                                        ])
    
    
    @EnvironmentObject var api:ClippyAPI
    //@EnvironmentObject var user:User
    @State var showingAlert:Bool
        
    var body: some View {
        NavigationView {
            VStack {
                Text("\(self.api.user.points ?? "0")").font(.largeTitle)
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
                                    OnboardingSetup().environmentObject(api)) {
                        Text("m-Clippy Onboarding")
                    }
                    NavigationLink(destination:
                                    Reporting()
                                        .environmentObject(api)
                            ) {
                        Text("m-Clippy Tips!")
                    }
                }
                Spacer()
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                        .padding(0)

                    Text("Which kind of consumer are you? Set the preferences and Clippy will help you with some tips - especially in the areas eating habits, origin of products and allergies.")
                        
                }.padding(.init(top: 18, leading: 18, bottom: 18, trailing: 18))


            }
            .navigationBarTitle(Text("Profile: \(self.api.user.Name())"))
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
        ClippyAPI.Instance.GetUser { (user) in
            //self.user = user
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(showingAlert: false).environmentObject(ClippyAPI.Instance)
        }
    }
}
