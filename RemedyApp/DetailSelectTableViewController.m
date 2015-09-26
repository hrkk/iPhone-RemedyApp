//
//  DetailSelectTableViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 15/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "DetailSelectTableViewController.h"
#import "RemedyTableViewController.h"
#import "AFNetworking.h"
#import "Utilities.h"
#import "SelectItem.h"
#import "Prefs.h"

@interface DetailSelectTableViewController () {
    NSArray *detailList;
    IBOutlet UITableView *tableView;
}
@end

@implementation DetailSelectTableViewController

@synthesize remedyItem;
@synthesize problemType;
@synthesize activityIndicatorView;



- (void)viewDidLoad {
   [super viewDidLoad];
    
    
   NSLog(@"problemType: %@", problemType);
   self.navigationItem.title = NSLocalizedString(problemType, nil);
    /*
   if ([problemType isEqualToString:@"AREA"]) {
       detailList = [NSArray arrayWithObjects:@"Area 1", @"Area 2", @"Area 3",nil];
   } else if ([problemType isEqualToString:@"MACHINE"]) {
       detailList = [NSArray arrayWithObjects:@"Machine 1", @"Machine 2", @"Machine 3",nil];
   } else if ([problemType isEqualToString:@"ERROR_TYPE"]) {
       detailList = [NSArray arrayWithObjects:@"Fatal", @"Cricical", @"Nice to have",nil];
   } else if ([problemType isEqualToString:@"STATUS"]) {
       detailList = [NSArray arrayWithObjects:@"New", @"Open", @"New (re-assign)", @"Fixed", @"Closed",nil];
   }
    */
    
    // call web service manager
    /*
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:8080/RemedyAdminApp/areaControllerRest/"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             NSString *className = NSStringFromClass([responseObject class]);
             detailList = [Utilities loadFromJson:responseObject];
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
     */
    
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];

    
    // 1
    NSString *serviceUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    if ([problemType isEqualToString:@"AREA"]) {
        serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"areaControllerRest/"];
    } else if ([problemType isEqualToString:@"MACHINE"]) {
        serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"machineRest/"];
    } else if ([problemType isEqualToString:@"ERROR_TYPE"]) {
        serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyErrorRest/"];
    } else if ([problemType isEqualToString:@"STATUS"]) {
        serviceUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"statusRest/"];
    }
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        NSLog(@"JSON: %@", responseObject);
      
        detailList = [Utilities loadFromJson:responseObject];
        [self.activityIndicatorView stopAnimating];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Area's"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [detailList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableCell" forIndexPath:indexPath];
 
 // Configure the cell...
     SelectItem *item  =[detailList objectAtIndex:indexPath.row];
   //  NSString *string = [NSString stringWithFormat:@"%@", item.text];
 cell.textLabel.text = item.text;
 
 return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString:@"showRemedyMainPage"]) {
        NSLog(@"prepareForSegue : %@s", segue.identifier);
        RemedyTableViewController *dest = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SelectItem *item = [detailList objectAtIndex:indexPath.row];
//        NSString *id = [NSString stringWithFormat:@"%ld",indexPath.row];
        if ([problemType isEqualToString:@"AREA"]) {
            dest.remedyItem.areaID = item;
        } else if ([problemType isEqualToString:@"MACHINE"]) {
            dest.remedyItem.machineID = item;
        } else if ([problemType isEqualToString:@"ERROR_TYPE"]) {
            dest.remedyItem.errorTypeID = item;
        } else if ([problemType isEqualToString:@"STATUS"]) {
            dest.remedyItem.status = item;
        }
    } else {
        RemedyTableViewController *dest = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString* selectedText = [detailList objectAtIndex:indexPath.row];
        
        //self.remedyItem.area = selectedText;
        NSLog(@"%ld, selectedText %@", (long)indexPath.row, selectedText);
        //  self.toDoItem = selectedText;
        dest.remedyItem = remedyItem;
    }
}

@end
