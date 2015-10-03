//
//  Utilities.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 22/08/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "Utilities.h"
#import "SelectItem.h"
#import "RemedyItem.h"

@implementation Utilities 

+ (NSMutableArray*) loadFromJson:(NSArray*)allSelectItems {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(NSDictionary *selectItem in allSelectItems) {
        SelectItem *item = [[SelectItem alloc] initWithDictionary:selectItem];
        [array addObject:item];
    }
    return array;
}

+(NSMutableArray*) loadRemedyListFromJson:(NSArray*)allRemedys {
     NSMutableArray *array = [[NSMutableArray alloc] init];
    for(NSDictionary *JSONRemedy in allRemedys) {
        RemedyItem *item = [[RemedyItem alloc] initWithDictionary:JSONRemedy];
        [array addObject:item];
    }
    
     return array;
    
}

@end
