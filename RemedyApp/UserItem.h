//
//  UserItem.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 29/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

@property NSString *username;
@property NSString *email;
@property NSString *phoneNumber;

// Constructor
- (id) initWithDictionary:(NSDictionary *) dict;

@end
