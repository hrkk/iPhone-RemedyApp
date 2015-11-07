//
//  RemedyListTableViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 06/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemedyListTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

    @property (strong,nonatomic) NSMutableArray *filteredRemedyList;
    @property NSArray * remedyList;
    @property IBOutlet UISearchBar *remedySearchBar;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (IBAction)unwindToRemedyList:(UIStoryboardSegue *)segue;

@end
