//
//  ViewController.swift
//  JSONStarWars
//
//  Created by Gorrila 8Ball Ribs on 2016-05-16.
//  Copyright © 2016 Gorrila 8Ball Ribs. All rights reserved.
//

var peopleAddress = String("http://swapi.com/people/")
var planetAddress = String("http://swapi.com/planets/")


import Cocoa
import Foundation
import Darwin
    


    func viewDidLoad() {

        func parseMyJSON(theData : NSData) {
 
            print(theData)
            

            do {
        let json = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments)

                print(json)
                
                dispatch_async(dispatch_get_main_queue()) {

                    
                }
                
                
            } catch let error as NSError {
                print ("Failed to load: \(error.localizedDescription)")
            }
            
            
        }
        

        func getMyJSON() {
            let myCompletionHandler : (NSData?, NSURLResponse?, NSError?) -> Void = {
                
                (data, response, error) in
                print("")
                print("</here da data/>")
                print(data)
                print("")
                print("</here da respons/>")
                print(response)
                print("")
                print("</here da godforsaken errors/>")
                print(error)
                
                if let r = response as? NSHTTPURLResponse {
                    
                    if r.statusCode == 200 {
                        
                        if let d = data {
                        parseMyJSON(d)
                            
                        }
                        
                    }
                    
                }
                
            }
            
       
            let address : String = "http://swapi.co/api/people/?format=json"
            
            if let url = NSURL(string: address) {
                
                print(url)
                
                let urlRequest = NSURLRequest(URL: url)
                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config)
                let task = session.dataTaskWithRequest(urlRequest, completionHandler: myCompletionHandler)
                
                task.resume()
                
            } else {
                print("Error: Cannot create the NSURL object.")
                
            }
            
        }

        
}

    var representedObject: AnyObject? {
        didSet {
        }
    }



