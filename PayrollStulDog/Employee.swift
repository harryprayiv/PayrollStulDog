//
//  Employee.swift
//  PayrollStulDog
//
//  Created by Misha Lvovsky on 1/30/18.
//  Copyright © 2018 No. All rights reserved.
//

import Foundation

enum EmployeeType{
    case manager, exec, employee, hourly, salary
}

class Employee:CustomStringConvertible {
    var type:EmployeeType
    var yearsOnBoard:Int
    var id:Int
    var name:String
    static var nextEmployeeID = 0
    init(_ name:String) {
        id = Employee.nextEmployeeID
        Employee.nextEmployeeID += 1
        type = .employee
        yearsOnBoard = 0
        self.name = name
    }
    func workedAnotherYear() {
        self.yearsOnBoard += 1
    }
    var weeklySalary:Double {
        fatalError("No Salary")
    }
    var firstName:String? {
        let lastNam = name.components(separatedBy: " ")
        if (lastNam.count == 2){
            return name.components(separatedBy: " ")[1]
        }
        else {return nil}
    }
    var lastName:String? {
        let lastNam = name.components(separatedBy: " ")
        if (lastNam.count == 2){
            return name.components(separatedBy: " ")[1]
        }
        else {return nil}
    }
    var description: String {
        return "Employee Name :\(name) ID: \(id), Years Hired: \(yearsOnBoard)"
    }
}
