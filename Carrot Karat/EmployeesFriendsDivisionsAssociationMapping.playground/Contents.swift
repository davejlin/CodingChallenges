//: Playground - noun: a place where people can play

// Problem: Employees-Friends-Divisions Association Mapping

// Input 1. employeesInput: 3 comma separated data fields:  id, name, division
// Input 2. friendsInput: 2 comma separated data fields: ids of 2 employees who are friends
//
// Task 1: Associate each employee with his list of friends
// Task 2: Count the following:
//         1. The number of employees in each division
//         2. The number of employees per division who have friends outside of his division

import UIKit

var employeesInput = [
    "1,Alice,Engineering",
    "2,Bob,Engineering",
    "5,Cristy,Management",
    "7,David,Engineering",
    "8,Ellen,Design",
    "10,Felix,Management",
    "12,Ginger,Design",
    "15,Henry,Operations"
]

var friendsInput = [
    "1,2",
    "1,7",
    "1,5",
    "1,8",
    "2,7",
    "7,8",
    "8,12",
    "8,5"
]

func getFriendsMap(for employees:[String], with friends:[String]) -> [String: [String]] {
    var friendsMap = [String: [String]]()
    
    for employee in employees {
        let data = employee.components(separatedBy: ",")
        let employeeKey = data[0]
        friendsMap[employeeKey] = []
    }
    
    for friend in friends {
        let data = friend.components(separatedBy: ",")
        
        let friendKey0 = data[0]
        let friendKey1 = data[1]
        
        friendsMap[friendKey0]!.append(friendKey1)
        friendsMap[friendKey1]!.append(friendKey0)
    }
    
    return friendsMap
}

func getDivisionsData(for employees: [String], with friendsMap: [String: [String]]) -> [String:[String:Int]]{
    var divisionsData = [String:[String:Int]]()
    var idToDivisionMap = [String:String]()
    
    let keyNumberOfEmployees = "Employees"
    let keyNumberOfEmployeesWithFriendsOutsideOfHisDivision = "With Outside Friends"
    
    for employee in employees {
        let data = employee.components(separatedBy: ",")
        let id = data[0]
        let division = data[2]
        idToDivisionMap[id] = division
    }
    
    for (employeeId, friends) in friendsMap {
        if let division = idToDivisionMap[employeeId] {
            if divisionsData[division] == nil {
                divisionsData[division] = [String:Int]()
                divisionsData[division]![keyNumberOfEmployees] = 0
                divisionsData[division]![keyNumberOfEmployeesWithFriendsOutsideOfHisDivision] = 0
            }
            
            divisionsData[division]![keyNumberOfEmployees]! += 1
            
            for friendId in friends {
                let friendDivision = idToDivisionMap[friendId]
                if division != friendDivision {
                    divisionsData[division]![keyNumberOfEmployeesWithFriendsOutsideOfHisDivision]! += 1
                    break // only need to count a single outside association per employee
                }
            }
        }
    }
    
    return divisionsData
}

let friendsMap = getFriendsMap(for: employeesInput, with: friendsInput)
print(friendsMap)
print(getDivisionsData(for: employeesInput, with: friendsMap))
