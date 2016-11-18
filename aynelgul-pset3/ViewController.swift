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
    @IBAction func searchButton(_ sender: UIButton) {
        HTTPSrequest(title: movieRequest.text!)
    }
    
    
    // keep track of movies in watch list
    var database = UserDefaults.standard
    
    var titles = [String]()
    var descriptions = [String: String]()
    var data = [String: String]()
    var checkTitle = String()

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkTitle = titles[indexPath.row]
        self.performSegue(withIdentifier: "nextView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination: SecondViewController = segue.destination as! SecondViewController
        destination.newData = self.descriptions[checkTitle]!
        destination.titleData = self.checkTitle
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        cell.movieTitle.text = titles[indexPath.row]
        cell.movieDiscription.text = descriptions[titles[indexPath.row]]
        
        return cell
    }
    
    
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
                    self.data = json as! [String : String]
                    self.titles.append(json["Title"] as! String)
                    self.descriptions[self.data["Title"]!] = self.data["Plot"]
                    
                }
            } catch {
                // error handling
            }

        }).resume()
        TableView.reloadData()
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

