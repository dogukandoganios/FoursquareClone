//
//  uploadViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 28.07.2022.
//

import UIKit
import Parse

class uploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let placeNameTextField = UITextField()
    let placeTypeTextField = UITextField()
    let placeAtmoshereTextField = UITextField()
    let placeImage = UIImageView()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        placeNameTextField.attributedPlaceholder = NSAttributedString(string: "Place Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        placeNameTextField.layer.borderWidth = 1
        placeNameTextField.textAlignment = .center
        placeNameTextField.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.15 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeNameTextField)
        
        placeTypeTextField.attributedPlaceholder = NSAttributedString(string: "Place Type", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        placeTypeTextField.layer.borderWidth = 1
        placeTypeTextField.textAlignment = .center
        placeTypeTextField.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.215 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeTypeTextField)
        
        placeAtmoshereTextField.attributedPlaceholder = NSAttributedString(string: "Place Atmoshere", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        placeAtmoshereTextField.layer.borderWidth = 1
        placeAtmoshereTextField.textAlignment = .center
        placeAtmoshereTextField.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.28 - height * 0.05 / 2, width: width * 0.8, height: height * 0.05)
        view.addSubview(placeAtmoshereTextField)
        
        placeImage.image = UIImage(named: "select")
        placeImage.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.6 - height * 0.55 / 2, width: width * 0.8, height: height * 0.55)
        view.addSubview(placeImage)
        
        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizer))
        placeImage.addGestureRecognizer(gestureRecognizer)
        
        saveButton.setTitle("Next", for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        saveButton.addTarget(self, action: #selector(nextClick), for: UIControl.Event.touchUpInside)
        saveButton.frame = CGRect(x: width * 0.5 - width * 0.3 / 2, y: height * 0.93 - height * 0.05 / 2, width: width * 0.3, height: height * 0.05)
        view.addSubview(saveButton)
        
    }
    
    @objc func gestureRecognizer(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func nextClick(){
        
        if placeNameTextField.text != "" && placeTypeTextField.text != "" && placeAtmoshereTextField.text != "" && placeImage.image != nil {
            
            PlaceModel.sharedInstance.placeName = placeNameTextField.text!
            PlaceModel.sharedInstance.placeType = placeTypeTextField.text!
            PlaceModel.sharedInstance.placeAtmoshere = placeAtmoshereTextField.text!
            PlaceModel.sharedInstance.placeImage = placeImage.image!
            
            performSegue(withIdentifier: "selectPlace", sender: nil)
            
        }else{
            
            alert(alertTitle: "Error!", alertMessage: "Plane name , Place type , Place Atmoshere or İmage not nil!")
            
        }
    }
    
    func alert(alertTitle : String , alertMessage : String){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }

}
