//
//  Employee.swift
//  PayrollStulDog
//
//  Created by Misha Lvovsky on 1/30/18.
//  Copyright © 2018 No. All rights reserved.
//

import Foundation

enum EmployeeType{
    case Employee, Salaried, Hourly, Manager, Executive
}

class Employee:CustomStringConvertible {
    private static var nextEmployeeNumber = 1
    let lastName: String
    let firstName: String
    let employeeNumber: Int
    var employeeType: EmployeeType
    var yearsEmployeed: Int
    
    //weeklySalary is an abstract method
    func weeklySalary() -> Int {
        fatalError("It is illegal to make an Employee object")
    }
    
    func newYear() {
        yearsEmployeed += 1
    }
    
    func raise(amount: Int) {
        
    }
    
    init(lastName: String, firstName: String, yearsEmployeed: Int, employeeType: EmployeeType) {
        self.lastName = lastName
        self.firstName = firstName
        self.employeeNumber = Employee.nextEmployeeNumber
        Employee.nextEmployeeNumber += 1
        self.yearsEmployeed = yearsEmployeed
        self.employeeType = employeeType
    }
    
    var description: String{
        var desc = ""
        desc += "\(lastName), \(firstName)\n"
        desc += "  Employee Type: \(employeeType)\n"
        desc += "  Employee Number: \(employeeNumber)\n"
        desc += "  YearsEmployeed: \(yearsEmployeed)\n"
        desc += "  Weekly Salary: \(weeklySalary())\n"
        return desc
    }
}

class HourlyEmployee:Employee {
    var regularHours: Int
    var holidayHours: Int
    var hourlyPay: Int
    
    func workHours(hours: Int) {
        regularHours += hours
    }
    func workDoubleTimeHours(hours: Int) {
        holidayHours += hours
    }
    func newWeek() {
        regularHours = 0
        holidayHours = 0
    }
    override func weeklySalary() -> Int {
        var salary = Int(0)
        if (regularHours > 40) {
            salary += 40*hourlyPay
            if (regularHours > 80) {
                salary += hourlyPay*60
                salary += hourlyPay*(regularHours-80)*2
            }
            else {
                salary += Int(Double(hourlyPay)*(Double(regularHours) - 40)*1.5)
            }
        }
        else {
            salary = regularHours * hourlyPay
        }
        salary += holidayHours * 2 * hourlyPay
        return salary
    }
    override func raise(amount: Int) {
        hourlyPay += amount
    }
    override var description:String {
        var desc = super.description
        desc += "  Regular Hours Worked: \(regularHours)\n"
        desc += "  Holiday Hours Worked: \(holidayHours)\n"
        return desc
    }
    init(lastName: String, firstName: String, hourlySalary: Int) {
        holidayHours = 0
        regularHours = 0
        self.hourlyPay = hourlySalary
        super.init(lastName: lastName, firstName: firstName, yearsEmployeed: 0, employeeType: .Hourly)
        self.employeeType = .Hourly
    }
}
class SalariedEmployee: Employee {
    var yearlySalary: Int
    
    override func weeklySalary() -> Int {
        return Int(yearlySalary / 52)
    }
    override func raise(amount: Int) {
        yearlySalary += amount
    }
    init (lastName: String, firstName: String, annualSalary: Int) {
        self.yearlySalary = annualSalary
        super.init(lastName: lastName, firstName: firstName, yearsEmployeed: 0, employeeType: .Salaried)
    }
    override var description: String {
        var desc = super.description
        desc += "  Yearly Salary: \(yearlySalary)\n"
        return desc
    }
}

class ManagerEmployee: SalariedEmployee {
    var rating: Int
    override func weeklySalary() -> Int {
        var weeklySalary = super.weeklySalary()
        weeklySalary += (super.yearlySalary*(rating/10))/52
        return weeklySalary
    }
    
    func setManagerRating(newRating: Int) {
        rating = newRating
    }
    init (lastName: String, firstName: String, annualSalary: Int, initialManagerRating: Int) {
        self.rating = initialManagerRating
        super.init(lastName: lastName, firstName: firstName, annualSalary: annualSalary)
        self.employeeType = .Manager
    }
    override var description: String {
        var desc = super.description
        desc += "  Rating: \(rating)\n"
        return desc
    }
}
