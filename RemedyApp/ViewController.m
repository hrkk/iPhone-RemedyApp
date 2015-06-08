//
//  ViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 26/05/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize logonImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image =  [UIImage imageNamed:@"creme_brelee.jpg"];
    logonImage.image = image;
    // sørger for at hele billede kan ses
    logonImage.contentMode = UIViewContentModeCenter;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
