//
//  Utilities.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 22/08/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSMutableArray*) loadFromJson:(NSArray*)allSelectItems;

+(NSMutableArray*) loadRemedyListFromJson:(NSArray*)allRemedys;

//+(NSMutableArray*) loadSelectedAreasFromJson:(NSArray*)profile;

@end
