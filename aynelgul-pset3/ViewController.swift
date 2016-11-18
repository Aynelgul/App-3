//
//  ViewController.swift
//  aynelgul-pset3
//
//  Created by Aynel Gül on 15-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var movieRequest: UITextField!
    @IBAction func findMovie(_ sender: UITextField) {
        HTTPSrequest(title: movieRequest.text!)
    }
    
    var titles = [String]()
    var descriptions = [String]()
    
    
    func HTTPSrequest(title: String) {
        let title = movieRequest.text!.replacingOccurrences(of: " ", with: "+")

        let url = URL(string: "https://omdbapi.com/?t="+title+"&yplot=short&r=json")
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                // error?
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print (json)
                
                DispatchQueue.main.async {
                    self.titles.append(json["Title"] as! String)
                    self.descriptions.append(json["Plot"] as! String)
                }
            } catch {
                // error handling
            }

        }).resume()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        cell.movieDiscription.text = titles[indexPath.row]
        cell.movieDiscription.text = descriptions[indexPath.row]
        
        return cell
    }
    
}

