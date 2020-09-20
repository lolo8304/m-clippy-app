//
//  m_clippyApp.swift
//  m-clippy
//
//  Created by Lorenz Hänggi on 19.09.20.
//

import SwiftUI

import Foundation

@main
struct m_clippyApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsView(showingAlert: false).environmentObject(ClippyAPI.Instance)
        }
    }
}


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Array {

    subscript (range r: Range<Int>) -> Array {
        return Array(self[r])
    }


    subscript (range r: ClosedRange<Int>) -> Array {
        return Array(self[r])
    }
}


extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
