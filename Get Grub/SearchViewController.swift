//
//  SearchViewController.swift
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

// TODO: Consider using extensions to separate out methods on a per-delegate basis
class SearchViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var welcomeLabel : UILabel!
    @IBOutlet var infoLabel : UILabel!
    @IBOutlet var searchField : UITextField!
    @IBOutlet var searchButton : UIButton!
    @IBOutlet var foodImage : UIImageView!

    var nameParameter : String! // TODO: looks like this is currently only used in one place, can just use a local variable

    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!

    let apiConsoleInfo = YelpAPIConsole() // TODO: not being used here, remove
    let client = YelpAPIClient()

    var restaurantInfo = ["phone": "", "ratingimage": "", "address1": "", "address2": "", "status":"false", "name":""]
    var tableView = UITableView()
    var array = ["hi", "hey", "hello"]
    var dict = [NSObject : AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.delegate = self
        // TODO: create a method "setUpTableView" and move these there
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        // TODO: create a method "setUpLabelsAndButtons" and move these there
        welcomeLabel.alpha = 0
        infoLabel.alpha = 0
        searchField.alpha = 0
        searchButton.alpha = 0
        foodImage.alpha = 0
        searchButton.layer.borderColor = UIColor.blackColor().CGColor
        searchButton.layer.borderWidth = 1.0

        // TODO: create a method, you guessed it, "setUpLocationManager"...
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        textFieldShouldReturn(searchField)
        //textFieldDidBeginEditing(searchField)
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
    
    func createTableView() {
        // TODO: why don't you love storyboard?! :p
        // Honestly, I think what you should be doing is having the search screen, and then a results screen that you create in storyboard that's already a table view and you just pass the search results to it
        tableView.frame = CGRectMake(UIScreen.mainScreen().bounds.origin.x, searchField.frame.origin.y + searchField.frame.height , searchField.frame.width, (UIScreen.mainScreen().bounds.height / 2))
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }

    // TODO: organize your methods into more logical groupings, based on functionality
    // this method should prob be right next to `textFieldShouldReturn`
    func textFieldDidBeginEditing(textField: UITextField) {
        tableView.removeFromSuperview()
        self.searchButton.hidden = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //datasource method returning the what cell contains
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    @IBAction func searchFood(sender : AnyObject) {
        // TODO: instead, here you'd call the search method on SearchResultsSingleton, then segue to ResultsVC

        if (searchField.text != "") {
            nameParameter = searchField.text
            client.searchPlacesWithParameters(["term": "\(nameParameter)","ll": "\(latitude),\(longitude)","limit":"3"], successSearch: { (data, response) -> Void in
               // print(NSString(data: data, encoding: NSUTF8StringEncoding))
                let json = JSON(data: data)
                
//                self.createTableView()
                //self.searchButton.hidden = true
//                let name = json["businesses"][0]["name"].stringValue
//                let phone = json["businesses"][0]["display_phone"].stringValue
//                let openStatus = json["businesses"][0]["is_closed"].stringValue
//                let address = json["businesses"][0]["display_address "][0].stringValue
//                let address1 = json["businesses"][0]["display_address "][1].stringValue
//                self.restaurantInfo.updateValue(name, forKey: "name")
//                self.restaurantInfo.updateValue(phone, forKey: "phone")
//                self.restaurantInfo.updateValue(openStatus, forKey: "status")
//                self.restaurantInfo.updateValue(address, forKey: address)
//                self.restaurantInfo.updateValue(address, forKey: address1)
//                print(json["businesses"][0]["location"])
                })
                {
                    (error) -> Void in
                    print(error)
                }
            }
            
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO: fancy, but seems a bit premature ;) 
        // TODO: see my comments in your UIView extension
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

