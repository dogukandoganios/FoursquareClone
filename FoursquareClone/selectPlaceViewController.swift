//
//  selectPlaceViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import Parse
import MapKit

class selectPlaceViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    var locationManager = CLLocationManager()

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
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    @objc func chooseLocation(gestureRecognize : UIGestureRecognizer){
        
        if gestureRecognize.state == UIGestureRecognizer.State.began {
            
            let touchs = gestureRecognize.location(in: self.mapView)
            let coordinates = self.mapView.convert(touchs, toCoordinateFrom: self.mapView)
            
            let annatation = MKPointAnnotation()
            annatation.coordinate = coordinates
            annatation.title = PlaceModel.sharedInstance.placeName
            annatation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annatation)
            
            PlaceModel.sharedInstance.latitude = coordinates.latitude
            PlaceModel.sharedInstance.longitude = coordinates.longitude
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func saveClick(){
        
        let object = PFObject(className: "Places")
        object["name"] = PlaceModel.sharedInstance.placeName
        object["type"] = PlaceModel.sharedInstance.placeType
        object["atmoshere"] = PlaceModel.sharedInstance.placeAtmoshere
        object["latitude"] = PlaceModel.sharedInstance.latitude
        object["longitude"] = PlaceModel.sharedInstance.longitude
        
        if let imageData = PlaceModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5){
            
            object["image"] = PFFileObject(data: imageData)
            
        }
        
        object.saveInBackground { succed, error in
            
            if error != nil {
                
                self.alert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                
            }else{
                
                self.performSegue(withIdentifier: "toFeedVC", sender: self)
                
            }
            
        }
        
    }
    
    func alert(alertTitle : String, alertMessage : String){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func backClick(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
