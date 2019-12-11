//
//  ViewController.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 09/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    var temp = [ContactItem]()
    var contacts = [ContactItem]()
    var SearchBar = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling Fetch object function
        fetchObj()
    
        //Tableview
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        //SearchBar
        SearchBar = UISearchController(searchResultsController: nil)
        SearchBar.searchResultsUpdater = self
        SearchBar.obscuresBackgroundDuringPresentation = false
        SearchBar.searchBar.placeholder = "Search contact"
        self.navigationItem.searchController = SearchBar
        self.definesPresentationContext = true
    }
    
    
    /// Function to get Context
    /// - Returns: return nsmanagedObjectContext
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /// Function to fetch data from Core Data
    func fetchObj() {
        contacts.removeAll()
        temp.removeAll()
        let fetchRequest:NSFetchRequest<Contacts> = Contacts.fetchRequest()
        
        do {
            let fetchResult = try ViewController.getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let contactItem = ContactItem(name: item.name!, email: item.email!, number: item.number!)
                contacts.append(contactItem)
                temp.append(contactItem)
                print("\n name: "+contactItem.name+"\n Number: "+contactItem.email+"\n Email: "+contactItem.number+"\n")
            }
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
   // Delete Core Data
//    func deleteAllData(_ entity:String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try managedContext.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                managedContext.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
//        }
//    }
    
    /// UIBarButtonItem Function
    /// Calls different view controller of present VC with POP Over.
    @IBAction func addContacts(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier:"AddContactViewController") as! AddContactViewController
        addVC.modalTransitionStyle   = .crossDissolve
        addVC.modalPresentationStyle = .overCurrentContext
        addVC.delegate = self
        self.navigationController?.present(addVC, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchBar.isActive {
           return temp.count
        } else {
            return contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.userImage.image = #imageLiteral(resourceName: "man-300x300")
        
        let items = contacts[indexPath.row]
        
        if SearchBar.isActive {
            cell.contactName.text = temp[indexPath.row].name
        } else {
            cell.contactName.text = items.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SearchBar.isActive {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let addVC = storyBoard.instantiateViewController(withIdentifier:"Details") as! DetailsViewController
            let contactDetail = temp[indexPath.row]
            addVC.details = contactDetail
            self.navigationController?.pushViewController(addVC, animated: true)
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let addVC = storyBoard.instantiateViewController(withIdentifier:"Details") as! DetailsViewController
            let contactDetail = contacts[indexPath.row]
            addVC.details = contactDetail
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }
}


// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        temp = contacts.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        self.tableView.reloadData()
    }
}

// MARK: - RefreshDelegate protocol to reload a tableview after data is fetched from core data.
extension ViewController: RefreshDelegate {
    func RefreshTblView() {
        print("refresh")
        fetchObj()
    }
}

