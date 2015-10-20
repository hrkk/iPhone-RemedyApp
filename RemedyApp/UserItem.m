//
//  UserItem.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 29/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem

@synthesize username;
@synthesize email;
@synthesize phoneNumber;

- (id) initWithDictionary:(NSDictionary *) dict{
    if (self = [super init]) {
        self.username =[dict objectForKey:@"fullName"];
        self.email = [dict objectForKey:@"email"];
        self.phoneNumber =[dict objectForKey:@"phoneNumber"];

    }
    return self;
}
@end
