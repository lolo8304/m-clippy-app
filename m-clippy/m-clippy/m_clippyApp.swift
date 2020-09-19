//
//  m_clippyApp.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

@main
struct m_clippyApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsView(showingAlert: false).environmentObject(OnboardingAPI.Instance)
        }
    }
}


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
