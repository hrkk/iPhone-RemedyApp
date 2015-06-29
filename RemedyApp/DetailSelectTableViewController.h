//
//  DetailSelectTableViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 15/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemedyItem.h"


@interface DetailSelectTableViewController : UITableViewController

@property RemedyItem *remedyItem;
@property NSString *problemType;

@end
