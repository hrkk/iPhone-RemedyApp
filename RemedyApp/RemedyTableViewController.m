//
//  RemedyTableViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyTableViewController.h"
#import "ComposeViewController.h"
#import "DetailSelectTableViewController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 380.0f // bredden af description
#define CELL_CONTENT_MARGIN 20.0f

@interface RemedyTableViewController ()

@end

@implementation RemedyTableViewController

@synthesize remedyItem;


- (void)loadInitialData {
     NSLog(@"loadInitialData");
    remedyItem = [[RemedyItem alloc] init];
    remedyItem.description = @"Buy milk";
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    NSLog(@"unwindToList %@", remedyItem.areaID);
    [self.tableView reloadData];
}

+ (void)initialize {
     NSLog(@"initialize");
}

- (void)viewDidLoad {
     NSLog(@"viewDidLoad");
    [super viewDidLoad];
    [self loadInitialData];
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *label = nil;
    static NSString *simpleTableIdentifier = @"RemedyPrototypeCell";
     static NSString *simpleTableIdentifier2 = @"RemedyPrototypeCell2";
    
     // description - laver den første cell dynamisk
    
    if(indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
     
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }

        if( [cell.contentView subviews] == nil || [cell.contentView subviews].count == 0) {
            //cell.textLabel.text = @"kkk";
            // Configure the cell...               CGRectMake(x, y, width, height)
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 34)];
           // [label setNumberOfLines:1];
            label.backgroundColor = [UIColor clearColor];
            [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
            label.adjustsFontSizeToFitWidth = NO;
            [[cell contentView] addSubview:label];
        } else {
            label = [[cell.contentView subviews] objectAtIndex:0];
        }
        
        NSString *text = remedyItem.description;
        [label setText:text];
        [label setNumberOfLines:0];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
        return cell;
     
    } else {
        // Area
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier2 forIndexPath:indexPath];
        
        NSString *sample1 = @"Area";
        NSInteger sample2 = indexPath.row;
        
        NSString *areaLabel = [NSString stringWithFormat:@"%@%ld", sample1,
                              (long)sample2];
        
        cell.textLabel.text = areaLabel;
        NSLog(@"AREA %@",  remedyItem.areaID);
      //  cell.detailTextLabel.text = remedyItem.areaID;
        
        [cell layoutIfNeeded];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {  // the cell you want to be dynamic
        
        NSString *text = remedyItem.description;
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 44.0f);
        
        return height + (CELL_CONTENT_MARGIN * 2);
    }
    else {
        return 44; // return normal cell height
    }
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
    if ([segue.identifier isEqualToString:@"showRemedyDecription"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"prepareForSegue indexPath: %@ %ld", segue.identifier, (long)indexPath.row);
        UINavigationController *navigationController = segue.destinationViewController;
       ComposeViewController *dest = (ComposeViewController * )navigationController.topViewController;
        dest.description =  @"heps"; //remedyItem.description;
    }
    
    if ([segue.identifier isEqualToString:@"showRemedySelect"]) {
         UINavigationController *navigationController = segue.destinationViewController;
         DetailSelectTableViewController *dest = (DetailSelectTableViewController * )navigationController.topViewController;
         dest.remedyItem = remedyItem;
    }
}
@end
