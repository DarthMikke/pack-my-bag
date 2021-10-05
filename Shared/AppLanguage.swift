//
//  AppLanguage.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/10/2021.
//

import Foundation

public enum AppLanguage: String, CaseIterable, Identifiable {
    case system, en, nn, nb
    
    public var id: String { self.rawValue }
    public var long: String {
        if self.rawValue == "system" {
            let currentLangId = Locale.current.localizedString(forLanguageCode: Locale.current.languageCode ?? "system") ?? NSLocalizedString("Unknown language", comment: "")
            return String.localizedStringWithFormat(
                NSLocalizedString("Standard language %@", comment: ""),
                currentLangId)
        } else {
            return Locale.current.localizedString(forLanguageCode: self.rawValue)?.capitalized ?? self.rawValue
        }
    }
    public var short: String {
        if self.rawValue == "system" {
            return "system"
        } else {
            return self.rawValue
        }
    }
}
