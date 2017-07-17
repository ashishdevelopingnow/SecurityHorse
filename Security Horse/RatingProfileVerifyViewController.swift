//
//  RatingProfileVerifyViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class RatingProfileVerifyViewController: BaseViewController {

    @IBOutlet weak var bgPercentView : UIView!
    @IBOutlet weak var percentView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgPercentView.layer.cornerRadius = 6.0
        bgPercentView.layer.masksToBounds = true
        
        percentView.layer.cornerRadius = 6.0
        percentView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - override
    
    override func backButtonTapped(_ sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
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
