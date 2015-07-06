//
//  CameraViewController.h
//  RemedyApp
//
//  Created by Kasper Odgaard on 02/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "RemedyItem.h"

@interface CameraViewController : UIViewController
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
@property BOOL newMedia;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property UIImage *selectImage;
@property RemedyItem *remedyItem;
- (IBAction)useCamera:(id)sender;

- (IBAction)useCameraRoll:(id)sender;

@end
