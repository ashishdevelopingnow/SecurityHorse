//
//  RatingTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 20/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var starImageView1: UIImageView!

    @IBOutlet weak var starImageView2: UIImageView!
    @IBOutlet weak var starImageView5: UIImageView!
    @IBOutlet weak var starImageView4: UIImageView!
    @IBOutlet weak var starImageView3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData (dict : [String : AnyObject]) {
//         ["title" : "add email address" , "rating" : 1  , "selected" : true],
        
        checkMarkImageView.isHidden = true
        
        if let rating = dict["rating"] as? Int{
            setImageSelection(number: rating)
        }else{
            setImageSelection(number: 0)
        }
        if let selected = dict["selected"] as? Bool{
            checkMarkImageView.isHidden = !selected
        }
        if let tittle = dict["title"] as? String{
            lblTitle.text = tittle
        }
        
    }
    func setImageSelection (number : Int){
        let imageSelected = #imageLiteral(resourceName: "starSelected")
       setInitialImage()
        switch number {
        case 1:
            starImageView1.image = imageSelected
//            starImageView2.image = imageSelected
//            starImageView3.image = imageSelected
//            starImageView4.image = imageSelected
//            starImageView5.image = imageSelected
        case 2:
            starImageView1.image = imageSelected
            starImageView2.image = imageSelected
//            starImageView3.image = imageSelected
//            starImageView4.image = imageSelected
//            starImageView5.image = imageSelected
        case 3:
            starImageView1.image = imageSelected
            starImageView2.image = imageSelected
            starImageView3.image = imageSelected
//            starImageView4.image = imageSelected
//            starImageView5.image = imageSelected
        case 4:
            starImageView1.image = imageSelected
            starImageView2.image = imageSelected
            starImageView3.image = imageSelected
            starImageView4.image = imageSelected
//            starImageView5.image = imageSelected
        case 5:
            starImageView1.image = imageSelected
            starImageView2.image = imageSelected
            starImageView3.image = imageSelected
            starImageView4.image = imageSelected
            starImageView5.image = imageSelected
        default:
            break
        }
        
        
    }
    func setInitialImage(){
         let imageUnselected = #imageLiteral(resourceName: "starUnSelected")
        starImageView1.image = imageUnselected
        starImageView2.image = imageUnselected
        starImageView3.image = imageUnselected
        starImageView4.image = imageUnselected
        starImageView5.image = imageUnselected
        
    }

}
