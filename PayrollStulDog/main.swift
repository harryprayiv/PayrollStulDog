//
//  main.swift
//  PayrollStulDog
//
//  Created by Misha Lvovsky on 1/30/18.
//  Copyright © 2018 No. All rights reserved.
//
var employees = [Employee]()

var s = SalariedEmployee(lastName: "Jones", firstName: "Fred", annualSalary: 35000)
s.raise(amount:10000)
employees.append(s)

var h = HourlyEmployee(lastName: "Smith", firstName: "Phil", hourlySalary: 22)
h.raise(amount: 3)
h.workHours(hours:10)
h.workHours(hours: 40)
h.workHours(hours:35)
h.workDoubleTimeHours(hours: 20)
employees.append(h)

var m = ManagerEmployee(lastName: "Talbot", firstName: "Henry", annualSalary: 65000, initialManagerRating: 3)
m.raise(amount: 10000)
m.setManagerRating(newRating: 4)
employees.append(m)

for e in employees{print(e, "\n")}

print ("\n\nWeekly Payroll Check Run:\n")
for e in employees {
    print("\(e.lastName), \(e.firstName)")
    print("  Check Amount: \(e.weeklySalary())\n")
}
