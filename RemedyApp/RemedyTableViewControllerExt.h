//
//  RemedyTableViewControllerExt.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 08/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemedyItem.h"

@interface RemedyTableViewControllerExt : UITableViewController

- (IBAction)unwindRemedy:(UIStoryboardSegue *)segue;
@property RemedyItem *remedyItem;

@end
