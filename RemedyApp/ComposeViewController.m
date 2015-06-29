//
//  ComposeViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 09/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "ComposeViewController.h"
#import "RemedyTableViewController.h"
#define MaxMessageLength 190

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end

@implementation ComposeViewController

@synthesize description;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NSLog(@"viewDidLoad %@", description);
    // angiver title i navigationBar
//    self.navigationItem.title=  @"Your Title";
    [self updateBytesRemaining:description];

    _messageTextView.text = description;
    //  delegate to a current controller object, that is self:
    _messageTextView.delegate = self;
    // placerer teksten øverst
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_messageTextView becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RemedyTableViewController *dest = segue.destinationViewController;
 //   RemedyTableViewController *dest = (RemedyTableViewController * )navigationController.topViewController;
    NSLog(@"dest %@", _messageTextView.text);
    dest.remedyItem.description = _messageTextView.text;
    description = _messageTextView.text;
}


- (BOOL)textView:(UITextView*)theTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    NSString* newText = [theTextView.text stringByReplacingCharactersInRange:range withString:text];
    NSLog(@"shouldChangeTextInRange %@ ", newText);
    [self updateBytesRemaining:newText];
    return YES;
}

- (void)updateBytesRemaining:(NSString*)text
{
    NSLog(@"updateBytesRemaining %@", text);
    // Calculate how many bytes long the text is. We will send the text as
    // UTF-8 characters to the server. Most common UTF-8 characters can be
    // encoded as a single byte, but multiple bytes as possible as well.
    const char* s = [text UTF8String];
    size_t numberOfBytes = strlen(s);
    
    // Calculate how many bytes are left
    int remaining = MaxMessageLength - numberOfBytes;
    
    // Show the number of remaining bytes in the navigation bar's title
    if (remaining >= 0)
         self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"%d Remaining", nil), remaining];
    else
         self.navigationItem.title = NSLocalizedString(@"Text Too Long", nil);
    
    // Disable the Save button if no text is entered, or if it is too long
    self.saveButton.enabled = (remaining >= 0) && (text.length != 0);
}

@end


