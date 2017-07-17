//
//  ProfileEditTwitterTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 26/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ProfileEditTwitterTableViewCell: BaseMyProfileTableViewCell,UITextViewDelegate{
    
    @IBOutlet weak var bttnStartJobDate: UIButton!
    @IBOutlet weak var bttnEndJobDate: UIButton!
    
    @IBOutlet weak var bttnCross: UIButton!
    @IBOutlet weak var bttnLinkdin: UIButton!

    @IBOutlet weak var txtpositionTitle: UITextField!
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtEnd: UITextField?
    @IBOutlet weak var txtStart: UITextField!
    
    @IBOutlet weak var lblPostionDesc: UILabel!
    
    @IBOutlet weak var bgViewPostionDesc: UIView!
    
    @IBOutlet weak var txtFieldPositionDesc: UITextView!
//    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
     weak var linkedDetail : LinkedInProfile?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(object: AnyObject?, callBack: ((_ action : TAPPED_VALUE, _ object : AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
        
        lblPostionDesc.textColor = Constants.APP_TEXT_COLOR
//        bttnLinkdin.setTitleColor( Constants.APP_TEXT_COLOR, for: .normal)
        
        bgViewPostionDesc.backgroundColor = UIColor.white
        bgViewPostionDesc.layer.shadowOpacity = 0.7
        bgViewPostionDesc.layer.shadowOffset = CGSize.zero
        bgViewPostionDesc.layer.shadowRadius = 5.0
        bgViewPostionDesc.layer.shadowColor = UIColor.gray.cgColor
        
//        self.layoutIfNeeded()
        UtilsSwift.addInitilaText(txtpositionTitle, initaltext: "position title", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtLocation, initaltext: "location", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtCompanyName, initaltext: "company name", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtStart, initaltext: "start", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtEnd!, initaltext: "end", initalTextColor: Constants.APP_TEXT_COLOR)
        
        
       
        
        txtpositionTitle.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        txtLocation.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        txtCompanyName.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        
//        txtStart.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
//        txtEnd!.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
//        txtCompanyName.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        
        txtFieldPositionDesc.delegate = self
        
        linkedDetail = object as? LinkedInProfile
        
        self.setUI()
        //
    }
    
    func setUI(){
        
        if let linkProfl = linkedDetail {
            txtpositionTitle.text = linkProfl.positionTitle
            txtLocation.text = linkProfl.location
            txtCompanyName.text = linkProfl.companyName
            
            txtStart.text = linkProfl.startDate
            txtEnd?.text = linkProfl.endDate
            txtFieldPositionDesc.text = linkProfl.positionResponsibility
            
            
            txtpositionTitle.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            txtLocation.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            txtCompanyName.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            
            txtStart.isUserInteractionEnabled = false// !linkProfl.isFromLinkedIn
            txtEnd?.isUserInteractionEnabled = false// !linkProfl.isFromLinkedIn
            bttnStartJobDate.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            bttnEndJobDate.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            
            txtFieldPositionDesc.isUserInteractionEnabled = !linkProfl.isFromLinkedIn
            
            
            bottomView.isHidden =   linkProfl.isLastRow

            bttnCross.isHidden = linkProfl.isFromLinkedIn == true ? true : linkProfl.isFirstRow
        }else{
            txtpositionTitle.text = ""
            txtLocation.text = ""
            txtCompanyName.text = ""
            
            txtStart.text = ""
            txtEnd?.text = ""
            txtFieldPositionDesc.text = ""
            bottomView.isHidden = true
            bttnCross.isHidden = true
            
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textView text is ::::::::  \(textView.text)")
        linkedDetail?.positionResponsibility = textView.text
        
    }
    
    
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //
    //    }
    @objc private func textfieldDidChanged(_ sender : UITextField) {
        print("writen text is ::::::::  \(String(describing: sender.text))")
        if sender == txtpositionTitle {
            linkedDetail?.positionTitle = sender.text
        }else if sender == txtLocation {
            linkedDetail?.location = sender.text
        }else if sender == txtCompanyName {
            linkedDetail?.companyName = sender.text
        }else if sender == txtStart {
            linkedDetail?.startDate = sender.text
        }else if sender == txtEnd {
            linkedDetail?.endDate = sender.text
        }
        
        linkedDetail?.isFromLinkedIn = false
        
        
    }
    
    //MARK:- @IBACtion
    
    @IBAction func crossBttnTapped(_ sender: Any) {
        self.completion?(TAPPED_VALUE.LINKED_IN_DELETE, linkedDetail)
    }
    @IBAction func endJobTapped(_ sender: Any) {
        self.completion?(TAPPED_VALUE.END_DATE, linkedDetail)
    }
    
    @IBAction func startJobTapped(_ sender: Any) {
        self.completion?(TAPPED_VALUE.START_DATE, linkedDetail)
    }
    
    @IBAction func endJobTpped(_ sender: Any) {
        self.completion?(TAPPED_VALUE.END_DATE, linkedDetail)
    }
    
    @IBAction func startJobTpped(_ sender: Any) {
         self.completion?(TAPPED_VALUE.START_DATE, linkedDetail)
    }
    
    
}
