//
//  RemedyItem.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemedyItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@property NSString *description;
@property NSString *areaID;
@property NSString *machineID;
@property NSString *errorTypeID;
@end
