//
//  SecondViewController.swift
//  aynelgul-pset3
//
//  Created by Aynel Gül on 18-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var newData = String()
    var titleData = String()
    
    @IBOutlet weak var descriptionMovie: UITextView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(newData)

        descriptionMovie.text = newData
        titleMovie.text = titleData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
