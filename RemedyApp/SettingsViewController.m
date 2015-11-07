//
//  SettingsViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 12/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "SettingsViewController.h"
#import "AFNetworking.h"
#import "Prefs.h"
#import "AppDataCache.h"
#import "Utilities.h"
#import "SelectItem.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIView *subView;



@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"userRest/profile"];
    [manager GET:serviceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.activityIndicatorView stopAnimating];
             NSLog(@"JSON: %@", responseObject);
             
             // lets greb areas
             NSDictionary *areasDict =[responseObject objectForKey:@"areas"];
             
            

            
           
       //    NSArray *seletecdAreaList  = [Utilities loadSelectedAreasFromJson:responseObject];
           //  NSLog(@"%@",[AppDataCache shared].areaList);
             
           NSArray *areaList =[AppDataCache shared].areaList;
             
             
             int y = 250;
             int count = 1;
             
             for (int i=0; i< [areaList count]; i++){
                           
                                 // SelectItem *item = [object];
             //      NSLog(@"[%d]:%@",i,arrData[i]);
                 SelectItem *item = [areaList objectAtIndex:i];

                     NSLog(@"object: %@", item.text);
                 UISwitch *button = [[UISwitch alloc] initWithFrame:  CGRectMake(100, y, 160, 40)];
                 [button addTarget:self
                            action:@selector(aMethod:)
                  forControlEvents:UIControlEventValueChanged];
                 
                 // checker om den er sat eller ej
                 for(NSDictionary *dict in areasDict) {
                     NSString *id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
                     NSLog(@"area id: %@",  id);
                     if ([item.id isEqualToString:id]) {
                          button.on = TRUE;
                    }
                 }
                 
                 
                 [self.subView addSubview:button];
                 
                 UILabel *label = [[UILabel alloc] initWithFrame:  CGRectMake(10, y, 160, 40)];
                 
                 NSString *textLabel = [NSString stringWithFormat:@"%@", item.text];
                 label.text =textLabel;
                 count++;
                 [self.subView addSubview:label];
                 
                 y=y+40;
             }

             
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

-(void)aMethod:(id)sender{
    UISwitch *onoff = (UISwitch *) sender;
    int y = 100;
    int i = 5;
    
    if (onoff.on) NSLog(@"On");
    else  NSLog(@"Off");
    /*
    for (int x=0; x<=i; x++) {
        NSString *frameString = [NSString stringWithFormat:@"{{80, %i}, {160, 40}}", y];
        if ([NSStringFromCGRect(button.frame) isEqualToString:frameString])  {
            NSLog(@"button %i clicked..", x);
        }
        y= y+60;
    } 
     */
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
