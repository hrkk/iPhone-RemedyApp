//
//  SettingsViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 12/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIView *subView;



@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        int y = 250;
    int count = 1;
    for (int i=0; i<=5; i++) {
        UISwitch *button = [[UISwitch alloc] initWithFrame:  CGRectMake(100, y, 160, 40)];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventValueChanged];
    
        
        [self.subView addSubview:button];
        
          UILabel *label = [[UILabel alloc] initWithFrame:  CGRectMake(10, y, 160, 40)];
        
        NSString *textLabel = [NSString stringWithFormat:@"Area %d", count];
        label.text =textLabel;
        count++;
        [self.subView addSubview:label];

        y=y+40;
    }
    
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
