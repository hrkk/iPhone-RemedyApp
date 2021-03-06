//
//  ViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 26/05/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logonImage;
- (IBAction)logonButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@end

