//
//  ViewController.swift
//  CoreDataBasic
//
//  Created by Ghouse Basha Shaik on 20/11/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var employeeList = [Employee]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchResult: NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            let employeeList = try PersistanceService.context.fetch(fetchResult)
            self.employeeList = employeeList
            self.tableView.reloadData()
        }catch {}
    }

    @IBAction func addNewEmployeeButtonAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Employee", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Name"
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Age"
        }
        let actionButton = UIAlertAction(title: "Save", style: .default) {[unowned self] (_) in
            var eName = ""
            var eAge:Int16  = 0
            if let name = alert.textFields?.first?.text {
                eName = name
            }
            if let age = alert.textFields?.last?.text {
                eAge = Int16(age)!
            }
            let employee = Employee(context: PersistanceService.context)
            employee.name = eName
            employee.age = Int16(eAge)
            PersistanceService.saveContext()
            self.employeeList.append(employee)
            self.tableView.reloadData()
        }
        alert.addAction(actionButton)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let employee = employeeList[indexPath.row]
        cell?.textLabel?.text = employee.name
        cell?.detailTextLabel?.text = String(employee.age)
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
}

