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
    
    
    
    
    
    for (int i = 1; i <= 4; i++)
    {
        NSString *serviceUrl = nil;
        NSString *serverRoot = PREFS_SERVER_URL;
        serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"statusRest/"];
        
        if (i==1) {
            serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"areaControllerRest/"];
        } else if (i==2) {
            serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"machineRest/"];
        } else if (i==3) {
            serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyErrorRest/"];
        } else if (i==4) {
            serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"statusRest/"];
        }


    
        NSURL *url = [[NSURL alloc] initWithString:serviceUrl];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
        // 2
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            // 3
            NSLog(@"JSON: %@", responseObject);
            if(i==1) {
                [AppDataCache shared].areaList = [Utilities loadFromJson:responseObject];
                NSLog(@"%@",[AppDataCache shared].areaList);
            }
            else if(i==2) {
                [AppDataCache shared].machineList = [Utilities loadFromJson:responseObject];
                NSLog(@"%@",[AppDataCache shared].machineList);
            }
            else if(i==3) {
                [AppDataCache shared].errorTypeList = [Utilities loadFromJson:responseObject];
                NSLog(@"%@",[AppDataCache shared].errorTypeList);
            }
            else if(i==4) {
                [AppDataCache shared].statusList = [Utilities loadFromJson:responseObject];
                NSLog(@"%@",[AppDataCache shared].statusList);
                [self.activityIndicatorView stopAnimating];
            }
        
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            // 4
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Server data'"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alertView show];
        }];
    
        // 5
        [operation start];
    }

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
