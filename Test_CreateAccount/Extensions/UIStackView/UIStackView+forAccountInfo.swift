//
//  UIStackView+forAccountInfo.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit

extension UIStackView {
    static var forAccountInfo: UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }
}
