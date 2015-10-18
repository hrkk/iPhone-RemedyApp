//
//  MenuViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 13/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (IBAction)unwindMenu:(UIStoryboardSegue *)segue;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@end
