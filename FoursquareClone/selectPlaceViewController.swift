//
//  selectPlaceViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import Parse
import MapKit

class selectPlaceViewController: UIViewController {
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        mapView.frame = CGRect(x: width * 0.5 - width * 0.9 / 2, y: height * 0.5 - height * 0.8 / 2, width: width * 0.9, height: height * 0.8)
        view.addSubview(mapView)
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClick))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backClick))
        
    }
    
    @objc func saveClick(){
        
    }
    
    @objc func backClick(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
