//
//  String+getLowercasedWords.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 25.02.2022.
//

import Foundation

extension String {
    func containsOnlyOneWord() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
                return false
            }
        }
        catch {
            return false
        }
        return true
    }
}
