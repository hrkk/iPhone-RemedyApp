//
//  MenuViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 13/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "MenuViewController.h"
#import "AFNetworking.h"
#import "Prefs.h"
#import "AppDataCache.h"
#import "Utilities.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (IBAction)unwindMenu:(UIStoryboardSegue *)segue {
    NSLog(@"unwindMenu metode in MenuViewController");
//    UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"RemedyListID"];
  //  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
   // [self.navigationController pushViewController:navi animated:YES];
   // NSString *segueName = @"showList";
   // [self performSegueWithIdentifier: segueName sender: self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadStatus];
    
}


-(void)loadStatus {
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    NSString *serviceUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    NSString *authValue = [AppDataCache shared].authorization;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    
//    areaControllerRest
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"areaControllerRest/"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
                     [AppDataCache shared].areaList = [Utilities loadFromJson:responseObject];
                 NSLog(@"%@",[AppDataCache shared].areaList);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];

    
    // machineRest
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"machineRest/"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
             [AppDataCache shared].machineList = [Utilities loadFromJson:responseObject];
             NSLog(@"%@",[AppDataCache shared].machineList);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];
    
    // remedyErrorRest
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyErrorRest/"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
             [AppDataCache shared].errorTypeList = [Utilities loadFromJson:responseObject];
             NSLog(@"%@",[AppDataCache shared].errorTypeList);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];
    
    // statusRest
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"statusRest/"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             [AppDataCache shared].statusList = [Utilities loadFromJson:responseObject];
             NSLog(@"%@",[AppDataCache shared].statusList);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];
    
    // profile
    
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"userRest/profile2"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             _fullNameLabel.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"fullName"]];
             [self.activityIndicatorView stopAnimating];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];
    

}

/*
- (void)viewWillAppear: (BOOL) animated {
    NSString *segueName = @"showList";
    [self performSegueWithIdentifier: segueName sender: self];
}
*/
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
