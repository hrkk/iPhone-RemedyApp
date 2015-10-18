//
//  RemedyItem.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyItem.h"
#import "RemedyLog.h"

@implementation RemedyItem

@synthesize id;
@synthesize description;
@synthesize areaID;
@synthesize machineID;
@synthesize errorTypeID;
@synthesize image;
@synthesize status;
@synthesize assignedTo;
@synthesize logs;

- (id) initWithDictionary:(NSDictionary *) dict{
    if (self = [super init]) {
        self.id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
        self.description = [dict objectForKey:@"description"];
        self.assignedTo = [dict objectForKey:@"assignedTo"];
        // get status
        NSDictionary *statusDict =[dict objectForKey:@"status"];
        NSDictionary *areaDict =[dict objectForKey:@"area"];
        NSDictionary *errorTypeDict =[dict objectForKey:@"errorType"];
        NSDictionary *machineDict =[dict objectForKey:@"machine"];
        NSDictionary *logsDict =[dict objectForKey:@"logs"];
        
        NSLog(@"statusDict %@", statusDict );
        self.status = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [statusDict objectForKey:@"id"]] text:[statusDict objectForKey:@"displayText"]];
        self.areaID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [areaDict objectForKey:@"id"]] text:[areaDict objectForKey:@"displayText"]];
        self.errorTypeID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [errorTypeDict objectForKey:@"id"]] text:[errorTypeDict objectForKey:@"displayText"]];
        self.machineID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [machineDict objectForKey:@"id"]] text:[machineDict objectForKey:@"displayText"]];
        
      
        //NSLog(@" status id  %@ text %@" ,item.id, item.text);
        
        NSMutableArray *logArray = [[NSMutableArray alloc] init];
        for(NSDictionary *log in logsDict) {
            RemedyLog *remedyLog = [[RemedyLog alloc] initWithDictionary:log];
            [logArray addObject:remedyLog];
        }
        self.logs = logArray;
      
    }
    return self;
}

+ (id)createRemedyListItem:(NSString *)id description:(NSString *)description areaID:(SelectItem*)areaID status:(SelectItem*)status assignedTo:(NSString*)assignedTo;
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
