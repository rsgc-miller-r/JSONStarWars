//
//  FirstViewController.swift
//  JSONSTARWARSios
//
//  Created by Gorrila 8Ball Ribs on 2016-05-23.
//  Copyright © 2016 Gorrila 8Ball Ribs. All rights reserved.
//



// THIS IS THE PLANET CONTROLLER

import UIKit
import Foundation

var planetaddress = String("http://swapi.co/api/planets/?format=json")

class FirstViewController: UIViewController {
    
    
    func parseMyJSON(theData : NSData) {
        
        //print(theData)
        var isKill : String = ""
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments)
            
            //print(json)
            
            if let value = json as? [String : AnyObject] {
                if let results = value["results"] as? [AnyObject]{
                    //print(results)
                    for data in results {
                        let range = String(data["name"]).startIndex.advancedBy(9)..<String(data["name"]).endIndex.advancedBy(-1)
                        String(data["name"])
                        print(String(data["name"])[range])
                        isKill += (String(self.planetText.text) + String(data["name"])[range] + "\n")

                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.planetText.text = isKill
            }
            
            
        } catch let error as NSError {
            print ("Failed to load: \(error.localizedDescription)")
        }
        
        
    }
    
    
    func getMyJSON() {
        let myCompletionHandler : (NSData?, NSURLResponse?, NSError?) -> Void = {
            
            (data, response, error) in
            /*print("")
            print("</here da data/>")
            print(data)
            print("")
            print("</here da respons/>")
            print(response)
            print("")
            print("</here da godforsaken errors/>")
            print(error)*/
            
            if let r = response as? NSHTTPURLResponse {
                
                if r.statusCode == 200 {
                    
                    if let d = data {
                        self.parseMyJSON(d)
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        let address : String = planetaddress
        
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
    
    var representedObject: AnyObject? {
        didSet {
        }
    }

    @IBOutlet weak var planetText: UITextView!

    @IBAction func planetButton(sender: UIButton) {
        
        self.getMyJSON()
        
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
  
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
