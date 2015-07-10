//
//  RemedyItem.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyItem.h"

@implementation RemedyItem

@synthesize id;
@synthesize description;
@synthesize areaID;
@synthesize machineID;
@synthesize errorTypeID;
@synthesize image;
@synthesize status;
@synthesize assignedTo;

+ (id)createRemedyListItem:(NSString *)id description:(NSString *)description areaID:(NSString*)areaID status:(NSString*)status assignedTo:(NSString*)assignedTo;

{
    RemedyItem *newRemedyItem = [[self alloc] init];
    newRemedyItem.id = id;
    newRemedyItem.description = description;
    newRemedyItem.areaID = areaID;
    newRemedyItem.status = status;
    newRemedyItem.assignedTo = assignedTo;
    return newRemedyItem;
}

@end
