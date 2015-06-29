//
//  RemedyViewControllerExt.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 21/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemedyItem.h"

@interface RemedyViewControllerExt : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)unwindRemedy:(UIStoryboardSegue *)segue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property RemedyItem *remedyItem;

@end
