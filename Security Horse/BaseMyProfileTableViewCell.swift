//
//  BaseMyProfileTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 24/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
enum TAPPED_VALUE {
    case UPLOAD_PHOTO,FB_TAPPED,LINKED_IN_ADD,LINKED_IN_DELETE,CONNECT_LINKEDIN,DISCONNECTED_LINKEDIN , START_DATE , END_DATE , UPLOAD_IMAGE_LICENCE
}
class BaseMyProfileTableViewCell: UITableViewCell {
    
    var completion : ((_ action : TAPPED_VALUE , _ object : AnyObject?)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(object : AnyObject? , callBack : ((_ action : TAPPED_VALUE , _ object : AnyObject?)->Void)?) -> Void {
        completion = callBack
    }
    
}
