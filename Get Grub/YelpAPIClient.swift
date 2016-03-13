//
//  YelpAPIClient.swift
//  Yelp It Off
//
//  Created by David Lechón Quiñones on 18/08/15.
//
//

import Foundation
import OAuthSwift

// TODO: why does this need to be a struct? if the init is the only place they are used, you can just move these to be `let`s in the class below
struct YelpAPIConsole {
    var consumerKey = "-juUeNMM-9BHuamEp7Is7g"
    var consumerSecret = "zFbfCqoFPBx_psI1s4cm3ah8WHM"
    var accessToken = "QaolEjs33uqpzC7v99fQXc1-x4TscbCu"
    var accessTokenSecret = "-qI4tsWdod-yHPFWCG-CAZ266t4"
}


// TODO: overall fine so far, I see it’s a work in progress. my main suggestion would be to be sure you keep this as the most simple API wrapper possible - methods only for calling the API that return the raw response (which you are already doing).
class YelpAPIClient: NSObject {
    
    let APIBaseUrl = "https://api.yelp.com/v2/"
    let clientOAuth: OAuthSwiftClient?
    let apiConsoleInfo: YelpAPIConsole

    override init() {
        apiConsoleInfo = YelpAPIConsole()

        self.clientOAuth = OAuthSwiftClient(consumerKey: apiConsoleInfo.consumerKey, consumerSecret: apiConsoleInfo.consumerSecret, accessToken: apiConsoleInfo.accessToken, accessTokenSecret: apiConsoleInfo.accessTokenSecret)

        super.init()
    }
    
    /* 
    
    searchPlacesWithParameters: Function that can search for places using any specified API parameter
    
    Arguments:
    
        searchParameters: Dictionary<String, String>, optional (See https://www.yelp.co.uk/developers/documentation/v2/search_api )
        successSearch: success callback with data (NSData) and response (NSHTTPURLResponse) as parameters
        failureSearch: error callback with error (NSError) as parameter
    
    Example:
    
    var parameters = ["ll": "37.788022,-122.399797", "category_filter": "burgers", "radius_filter": "3000", "sort": "0"]
    
    searchPlacesWithParameters(parameters, successSearch: { (data, response) -> Void in
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }, failureSearch: { (error) -> Void in
        println(error)
    })
    
    
    */
    
    func searchPlacesWithParameters(searchParameters: Dictionary<String, String>, successSearch: (data: NSData, response: NSHTTPURLResponse) -> Void, failureSearch: (error: NSError) -> Void) {
        let searchUrl = APIBaseUrl + "search/"

        clientOAuth!.get(searchUrl, parameters: searchParameters, success: successSearch, failure: failureSearch)
    }
    
    /*
    
    getBusinessInformationOf: Retrieve all the business data using the id of the place
    
    Arguments:
    
        businessId: String
        localeParameters: Dictionary<String, String>, optional (See https://www.yelp.co.uk/developers/documentation/v2/business )
        successSearch: success callback with data (NSData) and response (NSHTTPURLResponse) as parameters
        failureSearch: error callback with error (NSError) as parameter
    
    Example:
    
    getBusinessInformationOf("custom-burger-san-francisco", successSearch: { (data, response) -> Void in
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }) { (error) -> Void in
        println(error)
    }
    
    */
    
    func getBusinessInformationOf(businessId: String, localeParameters: Dictionary<String, String>? = nil, successSearch: (data: NSData, response: NSHTTPURLResponse) -> Void, failureSearch: (error: NSError) -> Void) {
        let businessInformationUrl = APIBaseUrl + "business/" + businessId

        // TODO: ternary here as well
        var parameters = localeParameters
        if parameters == nil {
            parameters = Dictionary<String, String>()
        }

        // TODO: add more spacing to improve readability, newlines between chunks of code doing diff things
        clientOAuth!.get(businessInformationUrl, parameters: parameters!, success: successSearch, failure: failureSearch)
    }
    
    /*
    
    searchBusinessWithPhone: Search for a business using a telephone number
    
    Arguments:
    
        phoneNumber: String
        searchParameters: Dictionary<String, String>, optional (See https://www.yelp.co.uk/developers/documentation/v2/phone_search )
        successSearch: success callback with data (NSData) and response (NSHTTPURLResponse) as parameters
        failureSearch: error callback with error (NSError) as parameter
    
    Example:
    
    searchBusinessWithPhone("+15555555555", successSearch: { (data, response) -> Void in
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }) { (error) -> Void in
        println(error)
    }
    
    */
    
    func searchBusinessWithPhone(phoneNumber: String, searchParameters: Dictionary<String, String>? = nil, successSearch: (data: NSData, response: NSHTTPURLResponse) -> Void, failureSearch: (error: NSError) -> Void) {
        let phoneSearchUrl = APIBaseUrl + "phone_search/"

        // TODO: can use a ternary here instead
        // parameters = searchParameters ? searchParameters : Dictionary<String, String>()
        var parameters = searchParameters
        if parameters == nil {
            parameters = Dictionary<String, String>()
        }
        
        parameters!["phone"] = phoneNumber
        
        clientOAuth!.get(phoneSearchUrl, parameters: parameters!, success: successSearch, failure: failureSearch)
    }
}
