//
//  NSDateFormatter+CAT.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "NSDateFormatter+CAT.h"


static NSString *const kCALDateFormatterType_dd_MM_yyyy = @"dd/MM/yyyy";
static NSString *const kCALDateFormatterType_MM_dd_yy = @"MM/dd/yy";
static NSString *const kCALDateFormatterType_HH_mm = @"HH:mm";
static NSString *const kCALDateFormatterType_EEEE_d_MMMM_yyyy = @"EEEE d MMMM yyyy";

NSString * dateFormatterFormatFromType(CALDateFormatterType type);

NSString * dateFormatterFormatFromType(CALDateFormatterType type)
{
    switch (type) {
        case CALDateFormatterType_dd_MM_yyyy:
            return kCALDateFormatterType_dd_MM_yyyy;
    	
    	case CALDateFormatterType_MM_dd_yy:
    		return kCALDateFormatterType_MM_dd_yy;
    		
        case CALDateFormatterType_HH_mm:
            return kCALDateFormatterType_HH_mm;
            
        case CALDateFormatterType_EEEE_d_MMMM_yyyy :
            return kCALDateFormatterType_EEEE_d_MMMM_yyyy;
            
        default: // unknow type
            return nil;
            break;
    }
    return nil;
}

@implementation NSDateFormatter (CAT)

+ (instancetype) dateFormatterForType:(CALDateFormatterType)type
{
    NSDictionary *threadDict = [[NSThread currentThread] threadDictionary];
    NSString *format = dateFormatterFormatFromType(type);
    NSDateFormatter *dateFormatter = nil;

    if (nil != format) {
        dateFormatter = [threadDict objectForKey:format];
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone systemTimeZone];
            dateFormatter.locale = [NSLocale systemLocale];
            dateFormatter.dateFormat = format;
            [threadDict setValue:dateFormatter forKey:format];
        }
    }

    return dateFormatter;
}

@end



