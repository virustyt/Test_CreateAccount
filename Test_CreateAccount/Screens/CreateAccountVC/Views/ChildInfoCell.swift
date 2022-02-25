//
//  ChildInfoCollectionViewCell.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit


fileprivate extension Consts {
    static var finalStackViewSpacing: CGFloat = 16

    static var finalStackViewTopInset: CGFloat = 20
    static var finalStackViewLeadingInset: CGFloat = 20
    static var finalStackViewTrailingInset: CGFloat = 20
    static var finalStackViewBottomInset: CGFloat = 20
}

class ChildInfoCell: UITableViewCell {

    static let identifyer: String = "ChildInfoCell"

    private var titleLabel: UILabel = {
        let label = UILabel.titleOneLabel
        label.text = "Enter childs personal info"
        return label
    }()

    private lazy var deleteChildsInfoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.addTarget(self, action: #selector(ChildInfoCell.deleteChildsInfoButtonTapped), for: .touchUpInside)
        return button
    }()

    private var firstNameLabel: UILabel = {
        let label = UILabel.titleTwoLabel
        label.text = "First Name"
        return label
    }()

    private var ageLabel: UILabel = {
        let label = UILabel.titleTwoLabel
        label.text = "Age"
        return label
    }()

    private var firstNameTextField = PersonalInfoTextField()
    private var ageTextField = PersonalInfoTextField()

    private lazy var firstNameStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(firstNameLabel)
        stack.addArrangedSubview(firstNameTextField)
        return stack
    }()

    private lazy var ageStackView: UIStackView = {
        let stack = UIStackView.forAccountInfo
        stack.addArrangedSubview(ageLabel)
        stack.addArrangedSubview(ageTextField)
        return stack
    }()

    private lazy var childInfoStackView: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [titleLabel, firstNameStackView, ageStackView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = Consts.finalStackViewSpacing
        return stack
    }()

    private lazy var finalStackView: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [childInfoStackView, deleteChildsInfoButton])
        stack.axis = .horizontal
        stack.alignment = .top

        childInfoStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        deleteChildsInfoButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stack.distribution = .fill
        stack.spacing = Consts.finalStackViewSpacing
        return stack
    }()

    private var deleteChildsInfoButtonClouser: (() -> ())?
    private var textFieldDelegate: UITextFieldDelegate?

    // MARK: - public funcs
    func setupCell(childNumber: Int, textFieldDelegate delegate: UITextFieldDelegate?, deleteButtonTapped: (() -> ())?) {
        deleteChildsInfoButtonClouser = deleteButtonTapped
        switch childNumber {
        case 0:
            titleLabel.text = "Enter first child personal info"
        case 1:
            titleLabel.text = "Enter second child personal info"
        case 2:
            titleLabel.text = "Enter third child personal info"
        case 3:
            titleLabel.text = "Enter fourth child personal info"
        case 4:
            titleLabel.text = "Enter fifth child personal info"
        default:
            break
        }
        setTextFieldsTags(childNumber: childNumber)

        textFieldDelegate = delegate
        setupDelegates()
    }

    // MARK: - inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setupConstraints() {
        contentView.addSubview(finalStackView)

        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finalStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: Consts.finalStackViewTopInset),
            finalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -Consts.finalStackViewBottomInset),
            finalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: Consts.finalStackViewTrailingInset),
            finalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -Consts.finalStackViewTrailingInset)
        ])
    }

    @objc private func deleteChildsInfoButtonTapped() {
        deleteChildsInfoButtonClouser?()
    }

    private func setTextFieldsTags(childNumber: Int) {
        switch childNumber {
        case 0:
            firstNameTextField.identifyer = TextFieldsTags.firstsChildFirstName
            ageTextField.identifyer = TextFieldsTags.firstChildAge
        case 1:
            firstNameTextField.identifyer = TextFieldsTags.secondsChildFirstName
            ageTextField.identifyer = TextFieldsTags.secondsChildAge
        case 2:
            firstNameTextField.identifyer = TextFieldsTags.thirdsChildFirstName
            ageTextField.identifyer = TextFieldsTags.thirdsChildAge
        case 3:
            firstNameTextField.identifyer = TextFieldsTags.thourthsChildFirstName
            ageTextField.identifyer = TextFieldsTags.thourthsChildAge
        case 4:
            firstNameTextField.identifyer = TextFieldsTags.fifthsChildFirstName
            ageTextField.identifyer = TextFieldsTags.fifthsChildAge
        default:
            break
        }
    }

    private func setupDelegates() {
        firstNameTextField.delegate = textFieldDelegate
        ageTextField.delegate = textFieldDelegate
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if deleteChildsInfoButton.layer.cornerRadius == 0 {
            deleteChildsInfoButton.layer.cornerRadius = deleteChildsInfoButton.frame.height / 2
        }
    }
}
