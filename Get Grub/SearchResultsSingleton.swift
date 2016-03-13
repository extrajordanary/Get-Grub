//
//  SearchResultsSingleton.swift
//  Get Grub
//
//  Created by Jordan on 3/12/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation

class SearchResultsSingleton: NSObject {
    // TODO: So this class would be a wrapper around the YelpAPIClass that handles calling those methods as well as dealing with the results. The reason for making this a singleton is that you are only ever showing the most recent results, so using a singleton, you can call a search method on it from the SearchViewController and then access the results in the ResultsViewController without having to pass any values. This also allows you to add some helper methods that handle supplying default search parameters, or that get the lat/lon directly from the LocationManager since right now all you are doing is getting the values in the ViewController and passing them to this class anyway

    // locationManager
    // recentResults - an array of RestaurantResults

    // be sure you set up the init method for this to be a singleton


    func searchWithString(string: String) {
        // get most current lat/lon from location manager
        // call YelpAPIClient’s searchPlacesWithParameters
    }

    func handleAPIResponse() {
        // this should be the block that you pass in when you call searchPlacesWithParameters

        // if response is good, call updateRestaurantResultsFromResponse, then searchSuccessful


        // if bad response, do something else - you'll need to think about whether that means you want to set results to nil, or leave them still set to whatever they were before. then call searchFailed so VC's can be informed
    }

    func updateRestaurantResultsFromResponse(response: String) { // im being lazy here, not sure what object type - JSON prob
        // empty current recentResults array
        // for each of the <=3 restaurant results, create a new RestaurantResult (initFromDictionary etc) and add it to the array
    }

    func searchSucceeded() {
        // subscribe your ViewControllers so they know when they can grab the new recentResults array to display
    }

    func searchFailed() {
        // subscribe your ViewControllers, and when they get triggered then you can display a UI error to the user if needed
    }
}
