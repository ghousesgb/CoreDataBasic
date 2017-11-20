//
//  Employee+CoreDataProperties.swift
//  CoreDataBasic
//
//  Created by Ghouse Basha Shaik on 20/11/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
