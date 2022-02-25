//
//  CreateAccountViewController.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit

fileprivate extension Consts {
    static var sectionOnesCellHeight: CGFloat = 500
    static var sectionTwosCellHeight: CGFloat = 270
    static var sectionThreesCellHeight: CGFloat = 50

    static var maxChildrensCount: Int = 5
}

class CreateAccountViewController: BaseViewController {

    private lazy var containerView: CreateAccountContainerView = {
        let containerView = CreateAccountContainerView()
        
        let containerViewFlow = CreateAccounVCFlow(alertControllerYesClouser: { [weak self] in self?.clearAllEnteredData() },
                                                   alertControllerNoClouser: {},
                                                   clearButtonClouser: { self.present(containerView.alertController, animated: true, completion: {}) },
                                                   tableViewDataSource: self,
                                                   tableViewDelegate: self)
        containerView.setContainerViewFlow(with: containerViewFlow)
        return containerView
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Create Account"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    deinit {
        removeObservers()
    }

    // MARK: - private funcs
    private func setupConstraints() {
        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    private func clearAllEnteredData() {
        UserPerasonalData.shared.childerens.removeAll()
        guard let cell = containerView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? UserInfoCell
        else { return }
        cell.ageTextField.text = nil
        cell.firstNameTextField.text = nil
        cell.lastNameTextField.text = nil
        cell.surnameNameTextField.text = nil
        containerView.tableView.reloadSections(IndexSet([0,1,2]), with: .fade)
    }

    @objc func handleKeyboardWillShow(notification: Notification) {
        if let newFrame = (notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
            containerView.tableView.contentInset = insets
            containerView.tableView.scrollIndicatorInsets = insets
        }
    }

    @objc func handleKeyboardDidHide(notification: Notification) {
        let insets = UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 )
        containerView.tableView.contentInset = insets
        containerView.tableView.scrollIndicatorInsets = insets
    }
}

// MARK: - UITableViewDelegate
extension CreateAccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - UITableViewDataSource
extension CreateAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return UserPerasonalData.shared.childerens.count
        case 2:
            if UserPerasonalData.shared.childerens.count < Consts.maxChildrensCount {
                return 1
            } else {
                return 0
            }
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setupUserInfoCell(tableView: tableView, for: indexPath)
        case 1:
            return setupChildInfoCell(tableView: tableView, for: indexPath)
        case 2:
            return setupAddChildCell(tableView: tableView, for: indexPath)
        default:
            return UITableViewCell()
        }
    }

    private func setupUserInfoCell(tableView: UITableView, for indexPath: IndexPath) -> UserInfoCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifyer, for: indexPath)
                as? UserInfoCell
        else {
            return UserInfoCell()
        }
        cell.setupCell(textFieldDelegate: self)
        return cell
    }

    private func setupChildInfoCell(tableView: UITableView, for indexPath: IndexPath) -> ChildInfoCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildInfoCell.identifyer, for: indexPath) as? ChildInfoCell
        else { return ChildInfoCell() }
        cell.setupCell(childNumber: indexPath.item, textFieldDelegate: self, deleteButtonTapped: { [weak self] in
            if UserPerasonalData.shared.childerens.count - 1 >= indexPath.item {
                UserPerasonalData.shared.childerens.remove(at: indexPath.item)
                self?.containerView.tableView.numberOfRows(inSection: 2)
                self?.containerView.tableView.numberOfRows(inSection: 1)
                self?.containerView.tableView.reloadSections(IndexSet([1,2]), with: .automatic)

                if UserPerasonalData.shared.childerens.count == Consts.maxChildrensCount - 1 {
                    self?.containerView.tableView.scrollToRow(at: IndexPath(item: 0,
                                                                            section: 2),
                                                              at: .bottom,
                                                              animated: true)
                }
            }
        })
        return cell
    }

    private func setupAddChildCell(tableView: UITableView, for indexPath: IndexPath) -> AddChildButtonCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddChildButtonCell.identifyer, for: indexPath)
                as? AddChildButtonCell
        else {
            return AddChildButtonCell(frame: .zero)
        }

        cell.setupCell(addButtonTappedClouser: { [weak self] in
            if UserPerasonalData.shared.childerens.count < Consts.maxChildrensCount - 1 {
                UserPerasonalData.shared.childerens.append(ChildPersonalData(firstName: "FirstName", age: 0))
                self?.containerView.tableView.reloadSections(IndexSet([1,2]), with: .automatic)
                self?.containerView.tableView.scrollToRow(at: IndexPath(item: 0,
                                                                        section: 2),
                                                          at: .bottom,
                                                          animated: true)
            } else if UserPerasonalData.shared.childerens.count == Consts.maxChildrensCount - 1 {
                UserPerasonalData.shared.childerens.append(ChildPersonalData(firstName: "FirstName", age: 0))
                self?.containerView.tableView.numberOfRows(inSection: 2)
                self?.containerView.tableView.numberOfRows(inSection: 1)
                self?.containerView.tableView.reloadSections(IndexSet([1,2]), with: .automatic)
                self?.containerView.tableView.scrollToRow(at: IndexPath(item: UserPerasonalData.shared.childerens.count - 1,
                                                                        section: 1),
                                                          at: .bottom,
                                                          animated: true)
            }
        })
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentTextField = textField as? PersonalInfoTextField
        else { return true }

        switch currentTextField.identifyer {
        case .userFirstName,
             .userLastName,
             .userSurname,
             .firstsChildFirstName,
             .secondsChildFirstName,
             .thirdsChildFirstName,
             .thourthsChildFirstName,
             .fifthsChildFirstName:
            return string.containsOnlyOneWord()
        case .userAge,
             .firstChildAge,
             .secondsChildAge,
             .thirdsChildAge,
             .thourthsChildAge,
             .fifthsChildAge:
            return string.containsOnlyOneNumber()
        default:
            return false
        }
    }


    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let currentTextField = textField as? PersonalInfoTextField
        else { return true }

        switch currentTextField.identifyer {
        case .userFirstName:
            UserPerasonalData.shared.firstName = currentTextField.text ?? ""
        case .userLastName:
            UserPerasonalData.shared.LastName = currentTextField.text ?? ""
        case .userSurname:
            UserPerasonalData.shared.surname = currentTextField.text ?? ""
        case .userAge:
            UserPerasonalData.shared.age = Int(currentTextField.text ?? "0") ?? 0

        case .firstsChildFirstName:
            addChildsName(textField.text, byChildIndex: 0)
        case .firstChildAge:
            addChildsAge(textField.text, byChildIndex: 0)

        case .secondsChildFirstName:
            addChildsName(textField.text, byChildIndex: 1)
        case .secondsChildAge:
            addChildsAge(textField.text, byChildIndex: 1)

        case .thirdsChildFirstName:
            addChildsName(textField.text, byChildIndex: 2)
        case .thirdsChildAge:
            addChildsAge(textField.text, byChildIndex: 2)

        case .thourthsChildFirstName:
            addChildsName(textField.text, byChildIndex: 3)
        case .thourthsChildAge:
            addChildsAge(textField.text, byChildIndex: 3)

        case .fifthsChildFirstName:
            addChildsName(textField.text, byChildIndex: 4)
        case .fifthsChildAge:
            addChildsAge(textField.text, byChildIndex: 4)
        default:
            break
        }
        return true
    }

    private func addChildsName(_ name: String?, byChildIndex childIndex: Int) {
        guard let recievedName = name
        else { return }

        if UserPerasonalData.shared.childerens.count > childIndex {
            UserPerasonalData.shared.childerens[childIndex].firstName = recievedName
        }
    }

    private func addChildsAge(_ age: String?, byChildIndex childIndex: Int) {
        guard let recievedAge = age,
              let correctAge = Int(recievedAge)
        else { return }

        if UserPerasonalData.shared.childerens.count > childIndex {
            UserPerasonalData.shared.childerens[childIndex].age = correctAge
        }
    }
}
