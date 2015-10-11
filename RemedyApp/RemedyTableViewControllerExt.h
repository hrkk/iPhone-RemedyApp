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
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonAction:(id)sender;

- (IBAction)unwindRemedy:(UIStoryboardSegue *)segue;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@property RemedyItem *remedyItem;

@end
