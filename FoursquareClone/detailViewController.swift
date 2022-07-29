//
//  detailViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import MapKit
import Parse

class detailViewController: UIViewController, MKMapViewDelegate{
    
    let placeImageView = UIImageView()
    let placeNameLabel = UILabel()
    let placeTypeLabel = UILabel()
    let placeAtmoshereLabel = UILabel()
    let detailMapView = MKMapView()
    var chosenPlaceId = ""
    var chosenlatitude = Double()
    var chonsenlogintude = Double()

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
        placeNameLabel.textAlignment = .center
        placeNameLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.45 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeNameLabel)
        
        placeTypeLabel.text = "sdfsdfasd"
        placeTypeLabel.textAlignment = .center
        placeTypeLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.51 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeTypeLabel)
        
        placeAtmoshereLabel.text = "sdfasdfasdf"
        placeAtmoshereLabel.textAlignment = .center
        placeAtmoshereLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.57 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeAtmoshereLabel)
        
        detailMapView.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.79 - height * 0.37 / 2, width: width * 0.8, height: height * 0.37)
        view.addSubview(detailMapView)
        
        detailMapView.delegate = self
        
        getData()
        
    }
    
    func getData(){
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            
            if error != nil{
                
                self.alert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                
            }else{
                
                if objects != nil{
                    
                    let myObject = objects![0]
                    
                    if let placename = myObject.object(forKey: "name") as? String{
                        
                        self.placeTypeLabel.text = placename
                        
                    }
                    
                    if let placetype = myObject.object(forKey: "type") as? String{
                        
                        self.placeTypeLabel.text = placetype
                        
                    }
                    
                    if let placeatmoshere = myObject.object(forKey: "atmoshere") as? String{
                        
                        self.placeAtmoshereLabel.text = placeatmoshere
                    }
                    
                    if let latitude = myObject.object(forKey: "latitude") as? Double{
                        
                        self.chosenlatitude = latitude
                        
                    }
                    
                    if let longitude = myObject.object(forKey: "longitude") as? Double{
                        
                        self.chonsenlogintude = longitude
                        
                    }
                    
                    if let imageData = myObject.object(forKey: "image") as? PFFileObject{
                        
                        imageData.getDataInBackground { data, error in
                            
                            if error != nil{
                                
                                self.alert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error")
                                
                            }else{
                                
                                self.placeImageView.image = UIImage(data: data!)
                                
                            }
                        }
                    }
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenlatitude, longitude: self.chonsenlogintude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailMapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.placeNameLabel.text!
                    annotation.subtitle = self.placeTypeLabel.text!
                    self.detailMapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            let reuseId = "myAnnotation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                pinView?.tintColor = UIColor.gray
                
                let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
                
            }else{
                
                pinView?.annotation = annotation
                
            }
            
            return pinView
            
        }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.chosenlatitude != 0.0 && self.chonsenlogintude != 0.0{
            
            let requestLocation = CLLocation(latitude: self.chosenlatitude, longitude: self.chonsenlogintude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                
                if error != nil {
                    
                    self.alert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                    
                }else{
                    
                    if let placemark = placemarks{
                        
                        if placemark.count > 0{
                            
                            let mkPlacemark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlacemark)
                            mapItem.name = self.placeNameLabel.text
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            
                            mapItem.openInMaps(launchOptions: launchOptions)
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func alert(alertTitle : String, alertMessage : String){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }

}
