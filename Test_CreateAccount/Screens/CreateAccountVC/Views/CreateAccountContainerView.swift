//
//  CreateAccountContainerView.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//



import UIKit

struct CreateAccounVCFlow {
    var alertControllerYesClouser: (() -> ())?
    var alertControllerNoClouser: (() -> ())?
    var clearButtonClouser: (() -> ())?

    var tableViewDataSource: UITableViewDataSource?
    var tableViewDelegate: UITableViewDelegate?
}

class CreateAccountContainerView: UIView {

    let tableView: UITableView = {
        let tablenView = UITableView()
        tablenView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifyer)
        tablenView.register(ChildInfoCell.self, forCellReuseIdentifier: ChildInfoCell.identifyer)
        tablenView.register(AddChildButtonCell.self, forCellReuseIdentifier: AddChildButtonCell.identifyer)
        tablenView.backgroundColor = .clear
        tablenView.delaysContentTouches = false
        tablenView.separatorStyle = .none
        return tablenView
    }()

    lazy var alertController: UIAlertController = {
                let alertController = UIAlertController(title: "Reset Data?",
                                                        message: nil,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Yes",
                                                        style: .default,
                                                        handler: alertControllerYesTapped(action:)))
                alertController.addAction(UIAlertAction(title: "No",
                                                        style: .default,
                                                        handler: self.alertControllerNoTapped(action:)))
                return alertController
            }()

    private let clearAccountsDataView = ClearAccountsDataView()
    private var alertYesTappedClouser: (() -> ())?
    private var alertNoTappedClouser: (() -> ())?

    // MARK: - public funcs
    func setContainerViewFlow(with flow: CreateAccounVCFlow) {
        clearAccountsDataView.clearButtonClouser = flow.clearButtonClouser
        alertYesTappedClouser = flow.alertControllerYesClouser
        alertNoTappedClouser = flow.alertControllerNoClouser
        tableView.delegate = flow.tableViewDelegate
        tableView.dataSource = flow.tableViewDataSource
    }

    // MARK: - inits
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private funcs
    private func setupConstraints() {
        addSubview(tableView)
        addSubview(clearAccountsDataView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        clearAccountsDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

            clearAccountsDataView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            clearAccountsDataView.leadingAnchor.constraint(equalTo: leadingAnchor),
            clearAccountsDataView.trailingAnchor.constraint(equalTo: trailingAnchor),
            clearAccountsDataView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func alertControllerYesTapped(action: UIAlertAction) {
        alertYesTappedClouser?()
    }

    @objc private func alertControllerNoTapped(action: UIAlertAction) {
        alertNoTappedClouser?()
    }
}
