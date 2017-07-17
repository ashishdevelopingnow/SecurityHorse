//
//  Utils.m
//  YIKYAK
//
//  Created by Aureans Technocraft on 09/12/2015.
//  Copyright © 2015 Aureans Technocraft. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSArray *)removeRedundantData:(NSArray *)array{
    NSMutableArray *mutableArray = [array mutableCopy];
    NSArray *copy = [mutableArray copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [mutableArray removeObjectAtIndex:index];
        }
        index--;
    }
    return copy;
    
//    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:array];
//    return [orderedSet array];

}

+(id)jsonobjectFromJsonString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    // you can skip this step by just using the NSData that you get from the http request instead of converting it to a string.
    NSError *localError;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
    if (localError) {
        return nil;
    }else{
        return jsonObject;
    }
    
}
+(NSString *)jsonStringFromObject:(id)object{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    NSString *tweet = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *tweet = [[NSString alloc] initWithData:jsonData encoding:NSUTF16BigEndianStringEncoding];
//    tweet = [tweet stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    return tweet;
    
//    NSString *trimmedTweet = [tweet stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    return trimmedTweet;

}
#pragma mark - userdefault



+(void)saveDataToUserDefault:(id)data key:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:data forKey:key];
    [userdefault synchronize];
}
+(id)dataFromUserDefaultForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

#pragma mark - dateFormatter
+(NSDate *)dateFromStringFormat:(NSString *)format dateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    NSDate *dd = [dateFormatter dateFromString:dateString];
    return dd;
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSLog(@"datt ::::  %@",[dateFormatter stringFromDate:date]);
    
}

+(NSString *)stringFromDateLocalformat:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Constrains
+(void)addToSuperViewWithConstrain:(UIView *)view superView:(UIView *)superView{

    view.translatesAutoresizingMaskIntoConstraints = NO;
//    view.tag = IMAGEVIEWTAG;
    [superView addSubview:view];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0]];
    
  
}

#pragma mark - Globle Methods

+(UIImage *)avtarImageWithAvtarID:(NSString *)image_id{
    
    if ([image_id isEqualToString:@"avt-op"]) {
        return [UIImage imageNamed:@"avt-x"];
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"avt-%d",image_id.intValue%99]];
}

+(NSString *)generateRandomStringWithLength:(int)lenth{
    NSString *letter = @"abcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *str = [NSMutableString stringWithCapacity:lenth];
    
    for (int i = 0; i < lenth; i++) {
        [str appendFormat:@"%c",[letter characterAtIndex:arc4random_uniform([letter length])]];
    }
    
    return str;
}

+(BOOL)checkForEmptyString:(NSString*)checkString {
    for (int i=0; i<checkString.length; i++) {
        if ([checkString characterAtIndex:i]!=' ') {
            return NO;
        }
    }
    return YES;
}

+(BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}" @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-" @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5" @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL result = [emailTest evaluateWithObject:candidate];
    
    return result;
    
}

+(void)showAlertWithMessage:(NSString *)message andTitle :(NSString *)title{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title?:APP_NAME message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

+(void)showNetworkError{
    [Utils showAlertWithMessage:@"Please check your network and try again" andTitle:nil];
}



@end
