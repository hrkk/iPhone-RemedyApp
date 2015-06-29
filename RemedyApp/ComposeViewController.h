//
//  ComposeViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 09/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController <UITextViewDelegate>
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *orginalDescription;

@end
