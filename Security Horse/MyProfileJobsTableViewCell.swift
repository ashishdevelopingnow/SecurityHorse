//
//  MyProfileJobsTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 24/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class MyProfileJobsTableViewCell: BaseMyProfileTableViewCell {
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var lblDesception: UILabel!
    @IBOutlet weak var lblSubTitle2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setData(object: AnyObject?, callBack: ((TAPPED_VALUE , AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
//        lblTitle.text = "Position"
//        lblSubTitle.text = ""
//        lblCompanyName.text = ""
////        lblSubTitle2.text = ""
//        let sampleText = "Describe your experience at this job as it best relates to the security industry.  Explain your role, responsibilities and type of work performed to provide hiring managers a good idea of your past experience and current skill set."
        
        let lnkProfile = object as! LinkedInProfile
        
        lblTitle.text = Utils.check(forEmpty:lnkProfile.positionTitle) ? "Position" : lnkProfile.positionTitle
        lblCompanyName.text = lnkProfile.companyName
        lblSubTitle.text = lnkProfile.location
        
        if !Utils.check(forEmpty: lnkProfile.startDate),!Utils.check(forEmpty: lnkProfile.endDate),  let startDate = lnkProfile.startDate , let endDate = lnkProfile.endDate {
            lblSubTitle2.text = "\(startDate) - \(endDate)"
        }else{
            lblSubTitle2.text = Utils.check(forEmpty:lnkProfile.positionTitle) ? "Duration of Role" : ""
        }
        
        
        let sampleText = !Utils.check(forEmpty:lnkProfile.positionResponsibility) ? (lnkProfile.positionResponsibility)! : "Describe your experience at this job as it best relates to the security industry.  Explain your role, responsibilities and type of work performed to provide hiring managers a good idea of your past experience and current skill set."
//        lblSubTitle2.text = Utils.check(forEmpty:lnkProfile?.dura) ? "Duration of Role" : lnkProfile?.positionTitle
        
        logoImageView.isHidden = !lnkProfile.isFromLinkedIn
        
//        "Here is a brief description of the various tasks the candidate performed at his or her previous position. It may also be a bulleted list:\n\t-Task one\n\t-Task two"
        
//        let sampleText = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: sampleText,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(value: 0)
            ])
        lblDesception.attributedText = attributedString
    }

}
