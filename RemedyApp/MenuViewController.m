//
//  MenuViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 13/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "MenuViewController.h"

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
