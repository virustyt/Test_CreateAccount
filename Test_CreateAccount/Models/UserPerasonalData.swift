//
//  UserPerasonalData.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 24.02.2022.
//

import Foundation

struct UserPerasonalData {

    static var shared: UserPerasonalData = UserPerasonalData(firstName: "FirstName", age: 0)

    var firstName: String
    var LastName: String?
    var surname: String?
    var age: Int
    var childerens: [ChildPersonalData] = []
}
