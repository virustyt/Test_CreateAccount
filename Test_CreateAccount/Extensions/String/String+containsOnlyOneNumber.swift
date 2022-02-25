//
//  String+getNumbers.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 25.02.2022.
//

import Foundation

extension String {
    func containsOnlyOneNumber() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^0-9 ].*", options: [])
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
