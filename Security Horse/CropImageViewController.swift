//
//  CropImageViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class CropImageViewController: BaseViewController , UIScrollViewDelegate {

    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var outletView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    
    var image : UIImage?
    var callBack : CallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.minimumZoomScale = 0.8
        scrollView?.delegate = self
        imageView?.image = image
        
        outletView?.backgroundColor = UIColor.clear
        outletView?.layer.shadowOpacity = 0.7
        outletView?.layer.shadowOffset = CGSize.zero
        outletView?.layer.shadowRadius = 5.0
        outletView?.layer.shadowColor = UIColor.gray.cgColor
        
        outletView?.layer.borderColor = UIColor.gray.cgColor
        outletView?.layer.borderWidth = 4
        
        outletView?.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    override func backButtonTapped(_ sender: UIButton?) {
        callBack?(false,nil)
    }
    @IBAction func doneButtonTapped (_ sender : UIButton) {
        callBack?(true,cropedImage())
//        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func cropRect() -> CGRect {
        let scale = imageView!.image!.size.width / imageView!.frame.width
        let cropRect = CGRect(x: scrollView!.contentOffset.x * scale, y: scrollView!.contentOffset.y * scale, width: outletView!.frame.width * scale, height: outletView!.frame.height * scale)
        return cropRect
    }
    
    var cropArea:CGRect{
        get{
            let factor = imageView.image!.size.width/view.frame.width
            let scale = 1/scrollView.zoomScale
            
            let imageFrame = imageView.imageFrame()
                        let x = (scrollView.contentOffset.x + outletView.frame.origin.x - imageFrame.origin.x) * scale * factor
                        let y = (scrollView.contentOffset.y + outletView.frame.origin.y - imageFrame.origin.y) * scale * factor
            
//            let imageFrame = imageView.imageFrame()
//            let x = (scrollView.contentOffset.x + outletView.frame.origin.x - imageFrame.origin.x) * scale * factor
//            let y = (scrollView.contentOffset.y + outletView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = outletView.frame.size.width * scale * factor
            let height = outletView.frame.size.height * scale * factor
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }

 
    
    
    func cropedImage() -> UIImage{
        scrollView.backgroundColor = UIColor.white
        
        let width = scrollView.frame.size.width
        let height = scrollView.frame.size.height
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
//        let scale = 1/scrollView.zoomScale
        
//        let imageFrame = imageView.imageFrame()
        
        let x = CGFloat.init(0)// CGFloat.init(-outletView.frame.origin.x) //(scrollView.frame.origin.x + outletView.frame.origin.x)
        let y = CGFloat.init(0)// CGFloat.init(-outletView.frame.origin.y) // (scrollView.frame.origin.y + outletView.frame.origin.y)
       
        let fffmmm = CGRect(x: x, y: y, width: width, height: height)
        
        
        self.scrollView.drawHierarchy(in: fffmmm, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        let imageRef = result.cgImage!.cropping(to: outletView.frame);
        let croppedImage = UIImage.init(cgImage: imageRef!)// [UIImage imageWithCGImage:imageRef];
//        CGImageRelease(imageRef!);
        
        return croppedImage
        
        let crp = cropArea
        UIGraphicsBeginImageContextWithOptions(cropArea.size, false, 0);
        scrollView.drawHierarchy(in: crp, afterScreenUpdates: true)
//            .drawViewHierarchyInRect(CGRectMake(-50,-5-,view.bounds.size.width,view.bounds.size.height), afterScreenUpdates: true)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        return image
        
//        UIGraphicsBeginImageContext(cropArea.size)
//        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        let aaa = UIImage.init(cgImage: (image?.cgImage)!)
//    
//        return aaa
        
//        let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropArea)
//        let croppedImage = UIImage(cgImage: croppedCGImage!)
////        imageView.image = croppedImage
//        return croppedImage
    }
}
extension UIImageView{
    func imageFrame()->CGRect{
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else{return CGRect.zero}
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        }else{
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }
}
