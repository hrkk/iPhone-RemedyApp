//
//  SelectItem.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 22/08/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectItem : NSObject
    @property NSString *id;
    @property NSString *text;

    // Constructor
    - (id) initWithDictionary:(NSDictionary *) dict;

    + (id)createEmptySelectItem;

    + (id)createSelectItem:(NSString*)id text:(NSString*)text;
@end
