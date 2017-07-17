//
//  FilterViewController.swift
//  Security Horse
//
//  Created by Aureans Technocraft on 20/04/2017.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var minAmount: CustomTextField!
    @IBOutlet weak var maxAmount: CustomTextField!
    @IBOutlet weak var duration: CustomTextField!
    @IBOutlet weak var durationTableView: UITableView!
   
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var address: CustomTextField!
    
    
    @IBOutlet weak var durationHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var addressHeightContrain: NSLayoutConstraint!
    
    var callBack : ((Int,Int,[String],[String])->Void)?
    
    var durationArray = ["Part Time", "Full Time"]
    var addressArray = ["Manhattan", "Brooklyn", "Bronx", "Queens", "Staten Island", "Westchester", "Northern New Jersey", "Western Connecticut"]
    
    var durationArraySelected : [String] = []
    var addressArraySelected : [String] = []
    
    var minmumAmount = 0
    var maximumAmount = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        durationHeightConstrain.constant = CGFloat(self.durationArray.count * 35)
        addressHeightContrain.constant = CGFloat(self.addressArray.count * 35)
        
        durationTableView.delegate = self
        addressTableView.delegate = self
        
        durationTableView.dataSource = self
        addressTableView.dataSource = self
        
        
        UtilsSwift.addInitilaText(minAmount, initaltext: "min hourly rate", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(maxAmount, initaltext: "max hourly rate", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(duration, initaltext: "by job type", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(address, initaltext: "by location", initalTextColor: Constants.APP_TEXT_COLOR)
        
        // Do any additional setup after loading the view.
        
        durationArraySelected.append(contentsOf: durationArray)
        addressArraySelected.append(contentsOf: addressArray)
        
        minAmount.text = "$\(minmumAmount) per hour"
        maxAmount.text = "$\(maximumAmount) per hour"
        
        minAmount.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        minAmount.addTarget(self, action: #selector(textfieldDidBegin(_:)), for: UIControlEvents.editingDidBegin)
        
        maxAmount.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        maxAmount.addTarget(self, action: #selector(textfieldDidBegin(_:)), for: UIControlEvents.editingDidBegin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - override methods
    override func backButtonTapped(_ sender: UIButton?) {
        self.dismiss(animated: true) { 
            
        }
    }
    // MARK: - text changed methods
    func textfieldDidChanged(_ sender : UITextView) {
        if sender == minAmount {
            if let aa = minAmount.text , let value = Int(aa){
                minmumAmount = value
            }else{
                minmumAmount = 0
            }
            minAmount.text = "$\(minmumAmount) per hour"
            
            
        }else if sender == maxAmount {
            if let aa = maxAmount.text , let value = Int(aa){
                maximumAmount = value
            }else{
                maximumAmount = 100
            }
            maxAmount.text = "$\(maximumAmount) per hour"
        }
    }
    func textfieldDidBegin(_ sender : UITextView) {
        if sender == minAmount {
            minAmount.text = "\(minmumAmount)"
        }else if sender == maxAmount {
            maxAmount.text = "\(maximumAmount)"
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func durationTapped(_ sender: Any) {
        self.view.endEditing(true)
        durationTableView.reloadData()
        
        self.durationHeightConstrain.constant = CGFloat(self.durationHeightConstrain.constant == 0 ? (self.durationArray.count * 35) : 0)
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addressTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        addressTableView.reloadData()
        self.addressHeightContrain.constant = CGFloat(self.addressHeightContrain.constant == 0 ? (self.addressArray.count * 35) : 0)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: - TableViewdelegate datasourse
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tableView(tableView, didDeselectRowAt: indexPath)
        self.view.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if tableView == durationTableView {
            
            let objec =  durationArray[indexPath.row]
            
            if durationArraySelected.contains(objec) {
                if let index = durationArraySelected.index(of: objec){
                    durationArraySelected.remove(at: index)
                
                
                cell?.imageView?.image = nil
                }
            }else{
                durationArraySelected.append(objec)
                cell?.imageView?.image = UIImage.init(named: "checkBlue")
            }
            
//            duration.text =
        }else if tableView == addressTableView {
//            address.text = addressArray[indexPath.row]
            let objec =  addressArray[indexPath.row]
            
            if addressArraySelected.contains(objec) {
                if let index = addressArraySelected.index(of: objec){
                addressArraySelected.remove(at: index)
                cell?.imageView?.image = nil
                }
            }else{
                addressArraySelected.append(objec)
                cell?.imageView?.image = UIImage.init(named: "checkBlue")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == durationTableView {
            return durationArray.count
        }else if tableView == addressTableView {
            return addressArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        if tableView == durationTableView {
            let objec = durationArray[indexPath.row]
            cell?.textLabel?.text = objec
            
            if durationArraySelected.contains(objec) {
                cell?.imageView?.image = UIImage(named : "checkBlue")
            }else{
                cell?.imageView?.image = nil
            }
            
            
        }else if tableView == addressTableView {
            
            let objec = addressArray[indexPath.row]
            if addressArraySelected.contains(objec) {
                cell?.imageView?.image = UIImage(named : "checkBlue")
            }else{
                cell?.imageView?.image = nil
            }
            
            cell?.textLabel?.text = objec
        }
        
        return cell!
    }
    
    @IBAction func doneButtnTapped (_ sender : UIButton) {
        self.view.endEditing(true)
        
        callBack?(minmumAmount,maximumAmount,durationArraySelected,addressArray)
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
