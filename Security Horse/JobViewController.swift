//
//  JobViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 25/12/16.
//  Copyright © 2016 Kuldeep Butola. All rights reserved.
//

import UIKit

class JobViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var jobTableView : UITableView!
    var job : Jobs?
    var jobArray = [JobsArray]()
    
    @IBOutlet weak var backBttn: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        jobTableView.delegate = self
        jobTableView.dataSource = self
        jobTableView.rowHeight = UITableViewAutomaticDimension
        jobTableView.estimatedRowHeight = 44.0

        self.addRefreshViewInTable(jobTableView)
        requestForRefreshView(nil)
        
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        backBttn.isHidden = UserDefault.getUserInfo() != nil
//        if UserDefault.getUserInfo() == nil {
//            <#code#>
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func refreshTable(_ sender: UIRefreshControl) {
        requestForRefreshView { () -> Void in
            sender.endRefreshing()
        }
    }
    //Mark UITableView delegate datasourse


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        if let count = job?.jobsArray?.count{
//            return count
//        }
        return jobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") as! JobTableViewCell
        cell.selectionStyle = .none
        cell .setdata(jobs: jobArray[indexPath.row])
//        if let jobarry = job?.jobsArray{
//            cell .setdata(jobs: jobArray[indexPath.row])
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let obj = job?.jobsArray?[indexPath.row]
        
        let obj = jobArray[indexPath.row]
        
        
        if let userId = UserDefault.getUserId() , obj.jobDescription?.viewed  != "1" , let jobId = obj.jobDescription?.id {
            
//            self.showHudWithMessage("")
            RequestClass.viewJob(jobid: jobId, userID: userId, result: { (returnObj, err, completed) in
//                self.hideHud()
                if completed {
                    
                }
            })
        
        }
        obj.jobDescription?.viewed = "1"
        jobTableView.reloadData()
        performSegue(withIdentifier: "jobDetails", sender: obj)
    }
    
    func showDetailPage (jobArray : JobsArray?) {
        
        
    }
    
     //Mark UIRefreshController
    func requestForRefreshView (_ completion : (() ->Void)?){
        RequestJobs.getJobList(0, userId: UserDefault.getUserId()) { (response, error, success) -> () in
            completion?()
            if let data = response as? Jobs {
                self.job = data
                self.reloadDataAndSort(jobs: data.jobsArray)
            }
        }
    }
    
    //MARK: - UISearchBarDelegate
    
    //    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool // return NO to not become first responder
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
    {
//        guard let text = searchBar.text else {return}
//        locationSearchTable?.updateSearch(text)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool // return NO to not resign first responder
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
    {
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        if Utils.check(forEmpty: searchText) == false {
        
            
            
            updateSearch(string: searchText)
            
            
        }else{
            self.reloadDataAndSort(jobs: job?.jobsArray)
//            locationSearchTable?.isHidden = true
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
    {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
    {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func updateSearch(string : String) {
//        let commitPredicate = NSPredicate(format: "(companyDetails.company_name CONTAINS[cd] %@) OR (jobDescription.job_title CONTAINS[cd] %@)" ,string,string)
        
//        jobArray.removeAll()
        var array = [JobsArray]()
        if let aa = job?.jobsArray {
            for data in aa {
                if let company = data.companyDetails?.company_name , company.lowercased().range(of: string.lowercased()) != nil{
                    array.append(data)
                }else if let company = data.jobDescription?.job_title , company.lowercased().range(of: string.lowercased()) != nil{
                    array.append(data)
                }
            }
        }
        self.reloadDataAndSort(jobs: array)
//        jobTableView.reloadData()
        
//        if let bb = aa?.filtered(using: commitPredicate) as? [JobsArray]{
//            jobArray.removeAll()
//            jobArray.append(contentsOf: bb)
//            jobTableView.reloadData()
//        }
        
    }
    
    func updateSearchWith(minAmt : Int, maxAmt : Int , jobType : [String], address : [String]) {
        //        let commitPredicate = NSPredicate(format: "(companyDetails.company_name CONTAINS[cd] %@) OR (jobDescription.job_title CONTAINS[cd] %@)" ,string,string)
        
        //        jobArray.removeAll()
        var array = [JobsArray]()
        if let aa = job?.jobsArray {
            for data in aa {
                
                if checkForMinAmount(minAmount: minAmt, data: data) ,
                checkForMaxAmount(maxAmount: maxAmt, data: data) ,
                checkForJobType(type: jobType, data: data) ,
                    checkForAddress(minAmount: address, data: data) {
                    array.append(data)
                }

            }
        }
        self.reloadDataAndSort(jobs: array)
       
        
    }
    
    func checkForMinAmount(minAmount : Int , data : JobsArray) -> Bool {
        if let min = data.jobDetails?.min_hourly_rate , let aa = Int(min), minAmount <= aa{
            return true
        }
        
        return false
    }
    func checkForMaxAmount(maxAmount : Int, data : JobsArray) -> Bool {
        if let min = data.jobDetails?.min_hourly_rate , let aa = Int(min), maxAmount >= aa{
            return true
        }
        return false
    }
    func checkForJobType(type : [String] , data : JobsArray) -> Bool {
//        if Utils.check(forEmpty: type)  == false , let jobType = type {
//            if jobType.lowercased() != data.jobDetails?.job_type?.lowercased() {
//                return false
//            }
//        }
        for value in type {
            if value.lowercased() == data.jobDetails?.job_type?.lowercased() {
                return true
            }
        }
        
        return false
    }
    func checkForAddress(minAmount : [String] , data : JobsArray) -> Bool {
        
        return true
        for value in minAmount {
            if data.jobDetails?.location_name?.lowercased().range(of: value.lowercased()) != nil {
                return true
            }
        }
        return false
        
    }
    
    // MARK: - TableData reload
    
    func reloadDataAndSort(jobs : [JobsArray]?)  {
        jobArray.removeAll()
        
        if let arr = jobs {
            jobArray.append(contentsOf: arr)
        }
        
        
        jobArray.sort(by: { (obj1, obj2) -> Bool in
//            2017-01-05 18:22:04
            let format = "yyyy-MM-dd HH:mm:ss"
            guard  let dateStr1 = obj1.jobDescription?.created_date_time , let dateStr2 = obj2.jobDescription?.created_date_time else{
                return false
            }
            

            
            guard let date1 = Utils.date(fromStringFormat: format, dateString: dateStr1 ) ,let date2 = Utils.date(fromStringFormat: format, dateString: dateStr2 ) else{
                return false
            }
            let result = date1.compare(date2)
            
            if result == ComparisonResult.orderedDescending{
                return true
            }
            return false
        })
        
        self.jobTableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jobDetails" {
            let viewCnt = segue.destination as? JobDetailsViewController
            viewCnt?.jobsArray = sender as? JobsArray
            viewCnt?.refreshView = {() in
                self.jobTableView.reloadData()
            }
            
        }else if segue.identifier == "filter"{
            let viewCnt = segue.destination as? FilterViewController
            viewCnt?.callBack = {(min,max,dd,adress) in
                self.updateSearchWith(minAmt:min , maxAmt: max, jobType: dd, address: adress)
            }
        }
    }
   

}
