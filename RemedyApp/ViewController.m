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
#import "AppDataCache.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logonButton:(id)sender {
    //
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];

    
    // validate
    NSLog(@"Validate: ");

    NSString *authStr = [NSString stringWithFormat:@"%@:%@", _userNameLabel.text, _passwordTextField.text];
    NSData *plainData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String);
    
    NSString *serviceUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"userRest/validate.json"];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
             // if ok save username password and move
             [AppDataCache shared].authorization = authValue;
             NSString *segueName = @"forwardToMenu";
             [self performSegueWithIdentifier: segueName sender: self];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username or password incorrect"
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}
@end
