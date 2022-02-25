//
//  PersonalInfoTextField.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 24.02.2022.
//

import UIKit

class PersonalInfoTextField: UITextField {

    let inset: CGFloat = 8
    var identifyer: TextFieldsTags?

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor

        let placeholderTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PatrickHand-Regular", size: 22) ??
                                                                            UIFont.systemFont(ofSize: 22),
                                                                        .foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        attributedPlaceholder = NSAttributedString(string: "...",
                                                   attributes: placeholderTextAttributes)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
