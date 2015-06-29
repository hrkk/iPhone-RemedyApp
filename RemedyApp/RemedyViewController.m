//
//  RemedyViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 16/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyViewController.h"

@interface RemedyViewController ()

@end

@implementation RemedyViewController

@synthesize remedyDescriptionTextView;
@synthesize problemPicImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // remedyDescriptionTextView.contentInset = UIEdgeInsetsMake(-7.0,0.0,0,0.0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    remedyDescriptionTextView.scrollEnabled = NO;
NSLog(@"text before: %.2f",self.remedyDescriptionTextView.frame.size.height);
  //  [remedyDescriptionTextView setText:@"ks Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Kasper Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat K nulla jncdjscndjdcndjscn dcndjcndjsc sdc dsnc dnc d cd cdn cjdkjdncjdfnvdfjv vjfnvjdfnvjdfnv"];
     [remedyDescriptionTextView sizeToFit]; //added
    [remedyDescriptionTextView setText:@"ks Lor"];
    [remedyDescriptionTextView layoutIfNeeded];
    
    CGFloat fixedWidth = remedyDescriptionTextView.frame.size.width;
    CGSize newSize = [remedyDescriptionTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = remedyDescriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    remedyDescriptionTextView.frame = newFrame;
    NSLog(@"text before: %.2f",self.remedyDescriptionTextView.frame.size.height);
     //  remedyDescriptionTextView
    
    // problemPic
   // UIImage *image =  [UIImage imageNamed:@"glad.jpg"];
   // problemPicImageView.image = image;
    
   // problemPicImageView.contentMode = UIViewContentModeScaleAspectFit;
    /*
    if (problemPicImageView.bounds.size.width > image.size.width && problemPicImageView.bounds.size.height > image.size.height) {
        problemPicImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
     */
    // sørger for at hele billede kan ses
  //  problemPicImageView.contentMode = UIViewContentModeCenter;
    
   // UIImage *imageToDisplay =
   // [UIImage imageWithCGImage:[image CGImage]
    //                    scale:1.0
    //              orientation: UIImageOrientationUp];
    // problemPicImageView.image = imageToDisplay;
    
 [self changeImages];

}

- (void)changeImages
{
    UIImage *image = [UIImage imageNamed:@"glad.jpg"];
    
    problemPicImageView.contentMode = UIViewContentModeScaleAspectFit;
    problemPicImageView.clipsToBounds = YES;
    [problemPicImageView setImage:image];
    [problemPicImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [problemPicImageView.layer setBorderWidth: 2.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
