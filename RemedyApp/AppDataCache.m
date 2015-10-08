//
//  AppDataCache.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 06/10/15.
//  Copyright © 2015 Kasper Odgaard. All rights reserved.
//

#import "AppDataCache.h"

@implementation AppDataCache

+ (AppDataCache *)shared{
    /*
     this method is implemented accordingly to:
     http://stackoverflow.com/questions/7568935/how-do-i-implement-an-objective-c-singleton-that-is-compatible-with-arc
     */
    static AppDataCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Do any other initialisation stuff here
        sharedInstance = [AppDataCache new];
    });
    return sharedInstance;
}

- (id) init{
    if( self = [super init] ){
        _statusList = [[NSMutableArray alloc] init];
        _areaList  = [[NSMutableArray alloc] init];
        _machineList = [[NSMutableArray alloc] init];
        _errorTypeList = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
