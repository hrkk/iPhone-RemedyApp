//
//  RemedyItem.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RemedyItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;


@property NSString *id;
@property NSString *description;
@property NSString *areaID;
@property NSString *machineID;
@property NSString *errorTypeID;
@property UIImage *image;
@property NSString *status;
@property NSString *assignedTo;

+ (id)createRemedyListItem:(NSString*)id description:(NSString*)description areaID:(NSString*)areaID status:(NSString*)status assignedTo:(NSString*)assignedTo;
@end
