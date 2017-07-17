//
//  MyJobsViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 13/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class MyJobsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var jobsArray = [JobsArray]()
    @IBOutlet weak var jobTableView : UITableView!
    
    deinit {
        removeNotification()
    }
    
    func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        jobTableView.isHidden = true
        jobTableView.delegate = self
        jobTableView.dataSource = self
        jobTableView.rowHeight = UITableViewAutomaticDimension
        jobTableView.estimatedRowHeight = 44.0
        setUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(jobApplied(notification:)), name: NSNotification.Name(rawValue: UserDefault.NOTIFICATION.Applied_Job), object: nil)
        // Do any additional setup after loading the view.
    }
    func jobApplied(notification: NSNotification){
//        let messageObj = notification.object as! Message;
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() {
        
        if let viewcnt = self.tabBarController?.viewControllers?[0] as? UINavigationController , let jobView = viewcnt.viewControllers[0] as? JobViewController , let array = jobView.job?.jobsArray {
//            let predicate = NSPredicate(format: "jobDescription.applied == %@","1")
//            if let abc = (array as? NSArray){
//                let bb = abc.filtered(using: predicate)
//                print(bb)
//            }
//            let arrayFor = [JobsArray]()
            jobsArray.removeAll()
            for obj in array {
                if obj.jobDescription?.applied == "1"{
                    jobsArray.append(obj)
                }
            }
            
//            if let aa = (array as NSArray).filtered(using: predicate) as? [JobsArray]{
            
//                jobsArray.append(contentsOf: aa)
                jobTableView.reloadData()
//            }
            
        }
        jobTableView.isHidden = jobsArray.count == 0
    }
    
    // MARK: - IBAction
    @IBAction func applyForJobTapped(_ sender : UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    //MARK: - UITableView delegate datasourse
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") as! JobTableViewCell
        cell.selectionStyle = .none
//        if let jobarry = jobsArray{
            cell .setdata(jobs: jobsArray[indexPath.row])
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = jobsArray[indexPath.row]
        
        
//        if let userId = UserDefault.getUserId() , obj?.jobDescription?.viewed  != "1" , let jobId = obj?.jobDescription?.id {
//            
//            //            self.showHudWithMessage("")
//            RequestClass.viewJob(jobid: jobId, userID: userId, result: { (returnObj, err, completed) in
//                //                self.hideHud()
//                if completed {
//                    
//                }
//            })
//            
//        }
//        obj?.jobDescription?.viewed = "1"
//        jobTableView.reloadData()
        performSegue(withIdentifier: "jobDetails", sender: obj)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jobDetails" {
            let viewCnt = segue.destination as? JobDetailsViewController
            viewCnt?.jobsArray = sender as? JobsArray
            viewCnt?.refreshView = {() in
                self.jobTableView.reloadData()
            }
            
        }
    }

}
