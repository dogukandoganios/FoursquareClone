//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 29.07.2022.
//

import Foundation
import UIKit

class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmoshere = ""
    var placeImage = UIImage()
    var latitude = Double()
    var longitude = Double()
    
    
    private init(){
        
    }
}
