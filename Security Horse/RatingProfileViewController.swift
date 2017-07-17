//
//  RatingProfileViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 19/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class RatingProfileViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var ratingTableView : UITableView!
    var ratingTableData =
        [
            ["title" : "Mobile Number Verified" , "rating" : 1  , "selected" : true],
            ["title" : "Facebook Verified" , "rating" : 2 ,"selected" : false],
            ["title" : "LinkedIn Verified" , "rating" : 3, "selected" : false],
            ["title" : "Phone Interview Verified" , "rating" : 4,"selected" : false],
            ["title" : "SecurityHorse Verified" , "rating" : 5,"selected" : false]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileModel = Profile.init()
         profileModel.initWithLinkedIn(false)
        let fbActive = profileModel.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false)
        profileModel.isFacebookActivated = fbActive
        
        ratingTableData =
            [
                ["title" : "Mobile Number Verified" , "rating" : 1  , "selected" : UserDefault.isMobileNumberVerified()],
                ["title" : "Facebook Verified" , "rating" : 2 ,"selected" : profileModel.isFacebookActivated],
                ["title" : "LinkedIn Verified" , "rating" : 3, "selected" : profileModel.isLinkedInActivated],
                ["title" : "Phone Interview Verified" , "rating" : 4,"selected" : false],
                ["title" : "SecurityHorse Verified" , "rating" : 5,"selected" : false]
        ]
        
        ratingTableView.delegate = self
        ratingTableView.dataSource = self
        ratingTableView.rowHeight = UITableViewAutomaticDimension
        ratingTableView.estimatedRowHeight = 44.0
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

    //Mark UITableView delegate datasourse
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ratingTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell") as! RatingTableViewCell
        cell.selectionStyle = .none
        let data = ratingTableData[indexPath.row]
        cell.setData(dict: data as [String : AnyObject])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
