//
//  ClearAccountDataView.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit

fileprivate extension Consts {
    static var clearButtonTopInset: CGFloat = 24
    static var clearButtonBottomInset: CGFloat = 30
    static var clearButtonLeadingInset: CGFloat = 20
    static var clearButtonTrailingInset: CGFloat = 20

    static var shadowOffset: CGSize = .init(width: 0, height: -4)
    static var shadowRadius: CGFloat = 120
}

class ClearAccountsDataView: UIView {

    var clearButtonClouser: (() -> ())?

    private let clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 22),
                                                         .foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: "Clear", attributes: attributes), for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        button.addTarget(self, action: #selector(ClearAccountsDataView.clearButtonTapped), for: .touchUpInside)

        return button
    }()

    // MARK: - inits
    init() {
        super.init(frame: .zero)
        setupConstraints()
        setupShadows()
        addTopBorder(to: self, with: .lightGray, andWidth: 4)
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setupConstraints() {
        addSubview(clearButton)

        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: topAnchor, constant: Consts.clearButtonTopInset),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Consts.clearButtonBottomInset),
            clearButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,
                                                 constant: Consts.clearButtonLeadingInset),
            clearButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor,
                                                  constant: -Consts.clearButtonTrailingInset),

            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupShadows() {
        layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        layer.shadowOffset = Consts.shadowOffset
        layer.shadowRadius = Consts.shadowRadius
    }

    private func addTopBorder(to customView: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        customView.addSubview(border)
    }

    @objc private func clearButtonTapped() {
        clearButtonClouser?()
    }
}
