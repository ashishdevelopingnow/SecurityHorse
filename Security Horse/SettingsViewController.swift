//
//  SettingsViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var bgSignOutView : UIView?
    @IBOutlet weak var bgSignOutSuperView : UIView?
    
    var tableData = [["new positions",true],["new messages",true],["new applications views",false],["expiring jobs posts",false],["profile information",true]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.rowHeight = UITableViewAutomaticDimension
        settingsTableView.estimatedRowHeight = 50

        bgSignOutSuperView?.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSignOutTapped(_ sender : AnyObject){
//        UserDefault.saveUserInfo(nil)
        UserDefault.signOut()
        performSegue(withIdentifier: "unwind", sender: nil)
    }
    @IBAction func signOutTapped (_ sender : UIButton){
        bgSignOutSuperView?.isHidden = false
        
        bgSignOutView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.bgSignOutView?.transform = CGAffineTransform.identity
        }) { (completed) in
            
        }
    }
    @IBAction func cancelTapped (_ sender : UIButton){
        bgSignOutSuperView?.isHidden = true
        
    }
    
    // MARK: - override
    
    override func backButtonTapped(_ sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - tableViewDelegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.section == 0 ? "baseCell" : "settingsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseSettingsTableViewCell
        if indexPath.section != 0 {
            cell.settingsData(tableData[indexPath.row])
        }
        return cell
    }
    // MARK: - Navigation
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
