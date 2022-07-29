//
//  feedViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import Parse

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addClick))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: width * 0.5 - width * 0.9 / 2, y: height * 0.5 - height * 0.9 / 2, width: width * 0.9, height: height * 0.9)
        view.addSubview(tableView)
        
        getData()
        
    }
    
    @objc func addClick(){
        
        self.performSegue(withIdentifier: "touploadVC", sender: nil)
        
    }
    
    @objc func logout(){
        
        PFUser.logOutInBackground { error in
            
            if error != nil {
                
                self.alert(errorTitle: "Error", errorMessage: error?.localizedDescription ?? "Error")
                
            }else{
                
                self.performSegue(withIdentifier: "tosignUp", sender: nil)
                
            }
            
        }
        
    }
    
    func alert(errorTitle : String, errorMessage : String){
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
    }
    
    func getData(){
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                
                self.alert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error")
                
            }else{
                
                if objects != nil{
                    
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        
                        if let placename = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId{
                                
                                self.placeNameArray.append(placename)
                                self.placeIdArray.append(placeId)
                                
                                
                            }
                            
                        }
                    }
                    
                    self.tableView.reloadData()
                    
                }
            }
            
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placeNameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = self.placeNameArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedId = placeIdArray[indexPath.row]
        performSegue(withIdentifier: "detailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsVC"{
            
            let destinationVC = segue.destination as! detailViewController
            destinationVC.chosenPlaceId = selectedId
            
        }
        
    }
    
}
