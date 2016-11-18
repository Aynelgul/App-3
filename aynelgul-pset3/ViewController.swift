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
                print(error!, "No movie found!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                DispatchQueue.main.async {
                    self.data = json as! [String: String]
                    self.titles.append(json["Title"] as! String)
                    self.descriptions[self.data["Title"]!] = self.data["Plot"]
                    self.TableView.reloadData()
                    self.updateDatabase()
                }
            } catch {
                print(error,"Could not load.")
            }
        }).resume()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        if (titles.count > 0) {
            database.set(titles, forKey: "Title")
            database.set(descriptions, forKey: "Plot")
            
        }
    }
    
    // Function when tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateDatabase() {
        self.database.set(self.titles, forKey: "Title")
        self.database.set(self.descriptions, forKey: "Plot")
    }
    
// werkt niet
//    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
//        
//        return cell
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

