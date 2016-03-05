//
//  ViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/3/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet var welcomeLabel : UILabel!
    @IBOutlet var infoLabel : UILabel!
    @IBOutlet var searchField : UITextField!
    @IBOutlet var searchButton : UIButton!
    @IBOutlet var foodImage : UIImageView!
    var nameParameter : String!
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let apiConsoleInfo = YelpAPIConsole()
    let client = YelpAPIClient()
    var array = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self

        welcomeLabel.alpha = 0
        infoLabel.alpha = 0
        searchField.alpha = 0
        searchButton.alpha = 0
        foodImage.alpha = 0
        searchButton.layer.borderColor = UIColor.blackColor().CGColor
        searchButton.layer.borderWidth = 1.0
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        textFieldShouldReturn(searchField)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func searchFood(sender : AnyObject) {
        if (searchField.text != "") {
            nameParameter = searchField.text
            client.searchPlacesWithParameters(["term": "\(nameParameter)","ll": "\(latitude),\(longitude)","limit":"3"], successSearch: { (data, response) -> Void in
               // print(NSString(data: data, encoding: NSUTF8StringEncoding))
                let json = JSON(data: data)
                for (key,subJson):(String, JSON) in json {
                    
                }
                
                })
                {
                    (error) -> Void in
                    print(error)
                }
            }
            
    }
    
    override func viewDidAppear(animated: Bool) {
        self.welcomeLabel.fadeIn(2, delay: 0.1, completion: {
            (finished : Bool) -> Void in

        })
        self.foodImage.fadeIn(2, delay: 0.4, completion: {
            (finished : Bool) -> Void in
            
        })
        self.infoLabel.fadeIn(2, delay: 0.7, completion: {
            (finished : Bool) -> Void in
            
        })
        self.searchField.fadeIn(2, delay: 1, completion: {
            (finished : Bool) -> Void in
            
        })
        self.searchButton.fadeIn(2, delay: 1.4, completion: {
            (finished : Bool) -> Void in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

