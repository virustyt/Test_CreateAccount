//
//  AddChildButtonCell.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 23.02.2022.
//

import UIKit

fileprivate extension Consts {
    static var addChildButtonLeadingInset: CGFloat = 20
}

class AddChildButtonCell: UITableViewCell {
    
    static let identifyer: String = "AddChildButtonCell"

    private var addChildButtonClouser: (() -> ())?

    private lazy var addChildButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(AddChildButtonCell.addChildButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - public funcs
    func setupCell(addButtonTappedClouser: (() -> ())?) {
        addChildButtonClouser = addButtonTappedClouser
    }

    func showAddButton() {
        addChildButton.isHidden = false
    }

    func hideAddButton() {
        addChildButton.isHidden = true
    }

    // MARK: - inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupConstraints()
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setupConstraints() {
        contentView.addSubview(addChildButton)

        addChildButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addChildButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addChildButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addChildButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: Consts.addChildButtonLeadingInset)
        ])
    }

    @objc private func addChildButtonTapped() {
        addChildButtonClouser?()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if addChildButton.layer.cornerRadius == 0 {
            addChildButton.layer.cornerRadius = addChildButton.frame.height / 2
        }
    }
}
