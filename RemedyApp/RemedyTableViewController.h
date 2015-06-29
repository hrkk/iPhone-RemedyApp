//
//  RemedyTableViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemedyItem.h"

@interface RemedyTableViewController : UITableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
@property RemedyItem *remedyItem;

@end
