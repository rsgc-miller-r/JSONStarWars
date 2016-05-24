//
//  SecondViewController.swift
//  JSONSTARWARSios
//
//  Created by Gorrila 8Ball Ribs on 2016-05-23.
//  Copyright © 2016 Gorrila 8Ball Ribs. All rights reserved.
//


// THIS IS THE PEOPLE CONTROLLER

import UIKit
import Foundation

var beel : Bool = false


var peopleaddress = String("http://swapi.co/api/people/?format=json")


class SecondViewController: UIViewController {
    
    
    func parseMyJSON(theData : NSData) {
        
        //print(theData)
        var isKill : String = ""
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments)
            
        //    print(json)
            
            if let value = json as? [String : AnyObject] {
                
                if let results = value["results"] as? [AnyObject]{
                    //print(results)
                    isKill = ""
                    print("IS 1")
                    print(isKill)
                    for data in results {
                        
                        let range = String(data["name"]).startIndex.advancedBy(9)..<String(data["name"]).endIndex.advancedBy(-1)
                        
                        if (beel == true) {
                            if (self.PeopleSearchText.text == String(data["name"])[range]) {
                                
                                print(data)
                               
                                isKill += "Height (cm): " + String(data["height"]) + "\n"
                                isKill += "Mass (kg): " + String(data["mass"]) + "\n"
                                isKill += "Hair Colour: " + String(data["hair_color"]) + "\n"
                                isKill += "Skin Colour: " + String(data["skin_color"]) + "\n"
                                isKill += "Eye Colour: " + String(data["eye_color"]) + "\n"
                                isKill += "Birth Year (Before Battle of Yavin): " + String(data["birth_year"]) + "\n"
                                isKill += "Gender: " + String(data["gender"]) + "\n"
                                
                            }
                            
                        } else {
                            
                            String(data["name"])
                            print(String(data["name"])[range])
                            isKill += (String(self.peopleText.text) + String(data["name"])[range] + "\n")
                            print("IS 2")
                            print(isKill)
                        }
                        
                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if isKill != "" {
                    self.peopleText.text = ""
                    self.peopleText.text = isKill
                }
                beel = false            }
            
            
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
        
        
        
        let address : String = peopleaddress
        
        if let url = NSURL(string: address) {
            
         //   print(url)
            
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
    
    @IBOutlet weak var peopleText: UITextView!
    //@IBOutlet weak var peopleStart: UIButton!
    
    @IBAction func peopleStart(sender: AnyObject) {
        
        self.getMyJSON()
        
    }
    
    @IBAction func PeopleSearchButton(sender: UIButton) {
        
        isKill = ""
        beel = true
        
        getMyJSON()
        
    }
    
    
    @IBOutlet weak var PeopleSearchText: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //peopleStart.addTarget(self, action: #selector(SecondViewController.getMyJSON), forControlEvents: .TouchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}