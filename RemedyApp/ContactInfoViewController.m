//
//  ContactInfoViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 29/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "UserItem.h"

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
     UserItem *userItem = [[UserItem alloc] init];
    userItem.username = @"Aldo Aldo";
    userItem.email = @"mail@mail.com";
    userItem.phoneNumber = @"12345678";
    self.navigationItem.title = NSLocalizedString(userItem.username, nil);
    emailLabel.text = userItem.email;
    _phoneNumberLabel.text = userItem.phoneNumber;
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
