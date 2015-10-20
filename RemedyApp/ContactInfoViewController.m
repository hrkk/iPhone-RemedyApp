//
//  ContactInfoViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 29/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "UserItem.h"
#import "AFNetworking.h"
#import "Prefs.h"
#import "AppDataCache.h"

@interface ContactInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation ContactInfoViewController

@synthesize userId;
@synthesize emailLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // TODO load user from service
    UserItem *userItem = nil; //[[UserItem alloc] init];
    
    NSString *serviceUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    NSString *authValue = [AppDataCache shared].authorization;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    //    /logRest/getUser/2
    serviceUrl = [NSString stringWithFormat:@"%@%@%@", serverRoot, @"logRest/getUser/",userId];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //         [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
                  UserItem *userItem =   [[UserItem alloc] initWithDictionary:responseObject];
            
             self.navigationItem.title = NSLocalizedString(userItem.username, nil);
             emailLabel.text = userItem.email;
             _phoneNumberLabel.text = userItem.phoneNumber;

            
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
      //       [self.activityIndicatorView stopAnimating];
             NSString *errMsg = [NSString stringWithFormat:@"Error Retrieving Server data %@", serviceUrl];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errMsg
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
