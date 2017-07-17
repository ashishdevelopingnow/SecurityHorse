//
//  DateMonthViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 30/03/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class DateMonthViewController: BaseViewController {

    var callBack : ((Date) -> Void)?
    
    @IBOutlet weak var datePicker : UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//
    override func backButtonTapped(_ sender: UIButton?) {
        
        self.dismiss(animated: true) { 
            
        }
    }
    
    @IBAction func doneBttnTapped(_ sender : UIButton) {
        callBack?(datePicker.date)
        backButtonTapped(nil)
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
