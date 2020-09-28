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
    //static let MigrosColorWhite:Color = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let MigrosColorWhite:Color = Color.offWhite
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
    var loaded:Bool {
        return self.api.loaded
    }
        
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Text("\(self.api.user.points ?? "0")").font(.largeTitle)
                    if (!self.api.loaded) {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.counterclockwise.circle")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                }.padding(0)
                Text("Cumulus-Points".t())
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Self.MigrosColor)
                HStack {
                    Text("Collection period".t()).font(.caption)
                    Text("\(Date(), formatter: Text.DateFormatMMYYYY)").font(.caption)
                    
                }.padding(0)
                Image("cumulus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(0)
                HStack {
                    HStack {
                        Spacer()
                        Text("Settings".t())
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
                    Section(header: Text("m-clippy")) {
                        if (self.api.loadedUser) {

                            NavigationLink(destination:
                                            OnboardingSetup().environmentObject(api)) {
                                Text("Onboarding".t())
                            }
                            NavigationLink(destination:
                                            OnboardingSetup().environmentObject(api)) {
                                Text("Scanning".t())
                            }
                        }
                        if (self.api.loaded) {
                            NavigationLink(destination:
                                            Reporting()
                                                .environmentObject(api)
                                    ) {
                                Text("Tips!".t())
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
                Spacer()
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                        .padding(0)

                    Text("Which kind of consumer are you? Set the preferences and Clippy will help you with some tips - especially in the areas eating habits, origin of products and allergies.".t())
                        .padding(0)

                }.padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            }
            .navigationBarTitle(Text("Profile: %@".tp(self.api.user.Name())))
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Text("Reset")
                    }
                    .accentColor(Self.MigrosColor)
                    .alert(isPresented:$showingAlert) {
                        Alert(title: Text("Are you sure you want to reset?".t()), message: Text("There is no undo".t()), primaryButton: .destructive(Text("Reset".t())) {
                            self.reset()
                        }, secondaryButton: .cancel())
                    }
                }
            )
        }
        .onAppear() {
            //self.reset()
        }
    }
    func reset() {
        User.RandomizeUserId()
        self.api.loaded = false
        self.api.loadedUser = false
        ClippyAPI.Instance.GetUser { (user) in
            self.api.user = user
        }
        ClippyAPI.Instance.GetMetaDataAllergens(completion: { (allergens) in
            DispatchQueue.main.async {
                self.api.staticAllergenes = allergens
                self.api.loadedUser = true
            }
        })
        ClippyAPI.Instance.GetReportings(completion: { (reportings) in
            DispatchQueue.main.async {
                self.api.reportings = reportings
                self.api.loaded = true
            }
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(showingAlert: false).environmentObject(ClippyAPI.Instance)
            SettingsView(showingAlert: false).environmentObject(ClippyAPI.Instance)
            SettingsView(showingAlert: false).preferredColorScheme(.dark).environmentObject(ClippyAPI.Instance)
        }
    }
}
