//
//  SelectItem.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 22/08/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "SelectItem.h"

@implementation SelectItem
    @synthesize id;
    @synthesize text;

- (id) initWithDictionary:(NSDictionary *) dict{
    if (self = [super init]) {
        self.id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
        self.text = [dict objectForKey:@"displayText"];
    }
    return self;
}

+ (id)createEmptySelectItem {
    SelectItem *item = [[SelectItem alloc] init];
    item.text = @" ";
    return item;
}

+ (id)createSelectItem:(NSString*)id text:(NSString*)text {
    SelectItem *newSelectItem = [[self alloc] init];
    newSelectItem.id = id;
    newSelectItem.text = text;
    return newSelectItem;
}

@end
