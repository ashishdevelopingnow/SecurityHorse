//
//  Utils.h
//  YIKYAK
//
//  Created by Aureans Technocraft on 09/12/2015.
//  Copyright © 2015 Aureans Technocraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define APP_NAME @"SecurityHorse"

#define USERDEFAULT_VALUE_GET(key) [Utils dataFromUserDefaultForKey:key]
#define USERDEFAULT_VALUE_SAVE(keys,data) [Utils saveDataToUserDefault:data key:keys]

typedef void (^CallBack)(BOOL result, id object);
@interface Utils : NSObject

+(NSArray *)removeRedundantData:(NSArray *)array;
+(id)jsonobjectFromJsonString:(NSString *)jsonString;
+(NSString *)jsonStringFromObject:(id)object;

+(void)saveDataToUserDefault:(id)data key:(NSString *)key;
+(id)dataFromUserDefaultForKey:(NSString *)key;

+(NSDate *)dateFromStringFormat:(NSString *)format dateString:(NSString *)dateString;
+(NSString *)stringFromDateLocalformat:(NSDate *)date format:(NSString *)format;

+(UIImage *)avtarImageWithAvtarID:(NSString *)image_id;

+(NSString *)generateRandomStringWithLength:(int)lenth;


+(BOOL)checkForEmptyString:(NSString*)checkString;
+(BOOL)validateEmail: (NSString *) candidate;

+(void)showAlertWithMessage:(NSString *)message andTitle :(NSString *)title;
+(void)showNetworkError;



+(void)addToSuperViewWithConstrain:(UIView *)view superView:(UIView *)superView;

@end
