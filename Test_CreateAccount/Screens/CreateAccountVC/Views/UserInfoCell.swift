//
//  UserInfoCollectionViewCell.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit

fileprivate extension Consts {
    static var userInfoStackViewSpacing: CGFloat = 16

    static var userInfoStackViewTopInset: CGFloat = 20
    static var userInfoStackViewLeadingInset: CGFloat = 20
    static var userInfoStackViewTrailingInset: CGFloat = 20
    static var userInfoStackViewBottomInset: CGFloat = 20

    static var textFieldContainerViewBorderWidth: CGFloat = 3
}

class UserInfoCell: UITableViewCell {

    static let identifyer: String = "UserInfoCell" 
    
    private var titleLabel: UILabel = {
        let label = UILabel.titleOneLabel
        label.text = "Enter your personal info"
        return label
    }()

    private var firstNameLabel: UILabel = {
        let label = UILabel.titleTwoLabel
        label.text = "First Name"
        return label
    }()

    private var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        return label
    }()

    private var surnameLabel: UILabel = {
        let label = UILabel.titleTwoLabel
        label.text = "Middle Name"
        return label
    }()

    private var ageLabel: UILabel = {
        let label = UILabel.titleTwoLabel
        label.text = "Age"
        return label
    }()

    var firstNameTextField = PersonalInfoTextField()
    var lastNameTextField = PersonalInfoTextField()
    var surnameNameTextField = PersonalInfoTextField()
    var ageTextField = PersonalInfoTextField()

    private lazy var firstNameStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(firstNameLabel)
        stack.addArrangedSubview(firstNameTextField)
        return stack
    }()

    private lazy var lastNameStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(lastNameLabel)
        stack.addArrangedSubview(lastNameTextField)
        return stack
    }()

    private lazy var surnameNameStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(surnameLabel)
        stack.addArrangedSubview(surnameNameTextField)
        return stack
    }()

    private lazy var ageStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(ageLabel)
        stack.addArrangedSubview(ageTextField)
        return stack
    }()

    private lazy var userInfoStackView: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [titleLabel,
                                                        firstNameStackView,
                                                        lastNameStackView,
                                                        surnameNameStackView,
                                                        ageStackView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = Consts.userInfoStackViewSpacing
        return stack
    }()

    private var textFieldDelegate: UITextFieldDelegate?

    // MARK: - public funcs
    func setupCell(textFieldDelegate delegate: UITextFieldDelegate?) {
        textFieldDelegate = delegate
        setupDelegates()
    }

    // MARK: - inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupConstraints()
        setTextFieldsTags()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setupConstraints() {
        contentView.addSubview(userInfoStackView)

        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                   constant: Consts.userInfoStackViewTopInset),
            userInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                      constant: -Consts.userInfoStackViewBottomInset),
            userInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                       constant: Consts.userInfoStackViewLeadingInset),
            userInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                        constant: -Consts.userInfoStackViewTrailingInset)
        ])
    }

    private func setTextFieldsTags() {
        self.firstNameTextField.identifyer = TextFieldsTags.userFirstName
        lastNameTextField.identifyer = TextFieldsTags.userLastName
        surnameNameTextField.identifyer = TextFieldsTags.userSurname
        ageTextField.identifyer = TextFieldsTags.userAge
    }

    private func setupDelegates() {
        firstNameTextField.delegate = textFieldDelegate
        lastNameTextField.delegate = textFieldDelegate
        surnameNameTextField.delegate = textFieldDelegate
        ageTextField.delegate = textFieldDelegate
    }
}
