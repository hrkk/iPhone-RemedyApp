//
//  AppDataCache.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 06/10/15.
//  Copyright © 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataCache : NSObject

@property (nonatomic,strong) NSArray *statusList;
@property (nonatomic,strong) NSArray *areaList;
@property (nonatomic,strong) NSArray *machineList;
@property (nonatomic,strong) NSArray *errorTypeList;
@property (nonatomic, assign) BOOL reload;
@property NSString *authorization;

+ (AppDataCache *)shared;

@end
