//
//  ViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 26/05/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Prefs.h"


@interface ViewController ()

@end

@implementation ViewController


@synthesize logonImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image =  [UIImage imageNamed:@"icon-100.png"];
    logonImage.image = image;
    // sørger for at hele billede kan ses
    logonImage.contentMode = UIViewContentModeCenter;
    
   NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"me", @"password"];
 //   NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
 //   NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64Encoding]];
    
    NSData *plainData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String);
    
    NSString *serviceUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"userRest/validate"];

     NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             // 4
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username or password incorrect'"
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];

         }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
