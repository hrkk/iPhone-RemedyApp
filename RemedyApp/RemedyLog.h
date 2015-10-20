//
//  RemedyLog.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 03/10/15.
//  Copyright © 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemedyLog : NSObject

@property NSString *userId;
@property NSString *lastUpdated;
@property NSString *status;
@property NSString *statusChangeByName;

// Constructor
- (id) initWithDictionary:(NSDictionary *) dict;

@end
