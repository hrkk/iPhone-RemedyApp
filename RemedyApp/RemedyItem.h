//
//  RemedyItem.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SelectItem.h"

@interface RemedyItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;


@property NSString *id;
@property NSString *description;
@property SelectItem *areaID;
@property SelectItem *machineID;
@property SelectItem *errorTypeID;
@property UIImage *image;
@property SelectItem *status;
@property NSString *assignedTo;

// Constructor
- (id) initWithDictionary:(NSDictionary *) dict;
- (id) initWithDictionary2:(NSDictionary *) dict;

+ (id)createRemedyListItem:(NSString*)id description:(NSString*)description areaID:(SelectItem*)areaID status:(SelectItem*)status assignedTo:(NSString*)assignedTo;
@end
