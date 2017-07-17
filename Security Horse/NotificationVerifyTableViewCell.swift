//
//  NotificationVerifyTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 08/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class NotificationVerifyTableViewCell: BaseNotificationTableViewCell {

    @IBOutlet weak var bttnVerify: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var starIamgeView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setCellUI() {
        bttnVerify.layer.borderWidth = 1
        bttnVerify.layer.borderColor = UIColor.white.cgColor
        bttnVerify.layer.masksToBounds = true
    }
    @IBAction func verifyTapped(_ sender: Any) {
    }

    @IBAction func cancelTapped(_ sender: Any) {
    }
}
