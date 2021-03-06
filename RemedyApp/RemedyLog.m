//
//  RemedyLog.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 03/10/15.
//  Copyright © 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyLog.h"

@implementation RemedyLog

@synthesize userId;
@synthesize lastUpdated;
@synthesize status;
@synthesize statusChangeByName;

- (id) initWithDictionary:(NSDictionary *) dict{
    if (self = [super init]) {
        self.lastUpdated = [dict objectForKey:@"lastUpdated"];
        // get status
        NSDictionary *statusDict =[dict objectForKey:@"status"];
        self.status =[statusDict objectForKey:@"displayText"];
        self.statusChangeByName = [dict objectForKey:@"statusChangeByName"];
        // get user
       // NSDictionary *userDict =[dict objectForKey:@"user"];
        self.userId =[dict objectForKey:@"userId"];
    }
    return self;

}

@end
