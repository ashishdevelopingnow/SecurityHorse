//
//  NotificationViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 03/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var notificationTableView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationTableView?.delegate = self
        notificationTableView?.dataSource = self
        notificationTableView?.estimatedRowHeight = 50
        notificationTableView?.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "verify"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseNotificationTableViewCell
        cell.setCellUI()
        return cell
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
