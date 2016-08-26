//
//  ViewController.swift
//  Weather Today
//
//  Created by ALLAN E JONES on 8/22/16.
//  Copyright © 2016 ALLAN E JONES. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=26cc94071445124c7600543b6308785f") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
            }
            else {
                if let urlContent = data {
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult)
                        print(jsonResult["name"])
                        if let description = ((jsonResult["weather"] as! NSArray)[0] as! NSDictionary)["description"] as? String {
                            DispatchQueue.main.sync(execute: {
                                self.descriptionLabel.text = description
                            })
                        }
                        if let temperature = ((jsonResult["main"] as! NSDictionary)[2] as! NSDictionary)["temp"] as? String {
                            DispatchQueue.main.sync(execute: {
                                self.temperatureLabel.text = temperature
                            })
                        }
                        if let pressure = ((jsonResult["main"] as! NSDictionary)[1] as! NSDictionary)["pressure"] as? Int {
                                DispatchQueue.main.sync(execute: {
                                self.pressureLabel.text = "\(pressure)"
                            })
                        }
                    }
                    catch {
                        print("JSON processing failed")
                    }
                }
            }
        }
        task.resume()
        } else {
            descriptionLabel.text = "Couldn't find weather for that city."
        }
    } // end submitButtonPressed
} // end program

