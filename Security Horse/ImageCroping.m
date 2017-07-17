//
//  ImageCroping.m
//  Security Horse
//
//  Created by Kuldeep Butola on 02/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

#import "ImageCroping.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@implementation ImageCroping

//+(void) getImageFromImageView:(UIImageView *)imageView  {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        CGImageRef resultRef = [self newTransformedImage:imageView.transform
//                                             sourceImage:imageView.CGImage
//                                              sourceSize:imageView.size
//                                       sourceOrientation:imageView.imageOrientation
//                                             outputWidth:self.outputWidth ? self.outputWidth : self.sourceImage.size.width
//                                                cropRect:self.cropRect
//                                           imageViewSize:self.imageView.bounds.size];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *transform =  [UIImage imageWithCGImage:resultRef scale:1.0 orientation:UIImageOrientationUp];
//            CGImageRelease(resultRef);
//            self.view.userInteractionEnabled = YES;
//            if(self.doneCallback) {
//                self.doneCallback(transform, NO);
//            }
//            [self endTransformHook];
//        });
//    });
//}
//+ (CGImageRef)newTransformedImage:(CGAffineTransform)transform
//                      sourceImage:(CGImageRef)sourceImage
//                       sourceSize:(CGSize)sourceSize
//                sourceOrientation:(UIImageOrientation)sourceOrientation
//                      outputWidth:(CGFloat)outputWidth
//                         cropRect:(CGRect)cropRect
//                    imageViewSize:(CGSize)imageViewSize
//{
//    CGImageRef source = sourceImage;
//    
//    CGAffineTransform orientationTransform;
//    [self transform:&orientationTransform andSize:&imageViewSize forOrientation:sourceOrientation];
//    
//    CGFloat aspect = cropRect.size.height/cropRect.size.width;
//    CGSize outputSize = CGSizeMake(outputWidth, outputWidth*aspect);
//    
//    CGContextRef context = CGBitmapContextCreate(NULL,
//                                                 outputSize.width,
//                                                 outputSize.height,
//                                                 CGImageGetBitsPerComponent(source),
//                                                 0,
//                                                 CGImageGetColorSpace(source),
//                                                 CGImageGetBitmapInfo(source));
//    CGContextSetFillColorWithColor(context,  [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, CGRectMake(0, 0, outputSize.width, outputSize.height));
//    
//    CGAffineTransform uiCoords = CGAffineTransformMakeScale(outputSize.width/cropRect.size.width,
//                                                            outputSize.height/cropRect.size.height);
//    uiCoords = CGAffineTransformTranslate(uiCoords, cropRect.size.width/2.0, cropRect.size.height/2.0);
//    uiCoords = CGAffineTransformScale(uiCoords, 1.0, -1.0);
//    CGContextConcatCTM(context, uiCoords);
//    
//    CGContextConcatCTM(context, transform);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextConcatCTM(context, orientationTransform);
//    
//    CGContextDrawImage(context, CGRectMake(-imageViewSize.width/2.0,
//                                           -imageViewSize.height/2.0,
//                                           imageViewSize.width,
//                                           imageViewSize.height)
//                       ,source);
//    
//    CGImageRef resultRef = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    return resultRef;
//}
@end
