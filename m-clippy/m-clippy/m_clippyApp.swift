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
