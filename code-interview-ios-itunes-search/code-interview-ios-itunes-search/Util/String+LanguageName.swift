//
//  String+LanguageName.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/30.
//

import Foundation

extension String {
    func languageNameFromISOCode() -> String? {
        let locale = Locale(identifier: "KO")
        return locale.localizedString(forLanguageCode: self)
    }
}
