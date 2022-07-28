//
//  detailViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import MapKit

class detailViewController: UIViewController {
    
    let placeImageView = UIImageView()
    let placeNameLabel = UILabel()
    let placeTypeLabel = UILabel()
    let placeAtmoshereLabel = UILabel()
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        placeImageView.image = UIImage(named: "select")
        placeImageView.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.25 - height * 0.3 / 2, width: width * 0.8, height: height * 0.3)
        view.addSubview(placeImageView)
        
        placeNameLabel.text = "asasd"
        placeNameLabel.layer.borderWidth = 1
        placeNameLabel.textAlignment = .center
        placeNameLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.45 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeNameLabel)
        
        placeTypeLabel.text = "sdfsdfasd"
        placeTypeLabel.layer.borderWidth = 1
        placeTypeLabel.textAlignment = .center
        placeTypeLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.51 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeTypeLabel)
        
        placeAtmoshereLabel.text = "sdfasdfasdf"
        placeAtmoshereLabel.layer.borderWidth = 1
        placeAtmoshereLabel.textAlignment = .center
        placeAtmoshereLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.57 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeAtmoshereLabel)
        
        mapView.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.79 - height * 0.37 / 2, width: width * 0.8, height: height * 0.37)
        view.addSubview(mapView)
        
    }

}
