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


extension String {
    public func t() -> String {
        return NSLocalizedString(self, comment:self)
    }
    public func t(text: String) -> String {
        return NSLocalizedString(self, value: text, comment:self)
    }

    public func tp(_ parameters: CVarArg...) -> String {
        return String(format: self.t(), arguments: parameters)
    }
    public func tp(text: String, _ parameters: CVarArg...) -> String {
        return String(format: self.t(text: text), arguments: parameters)
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225/255, blue: 235 / 255)
}

extension Text {
    static let DateFormatDDMMYYYY: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.locale = Locale(identifier: "de")
        return formatter
    }()
    static let DateFormatMMYYYY: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.YYYY"
        formatter.locale = Locale(identifier: "de")
        return formatter
    }()
}
