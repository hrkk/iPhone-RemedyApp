//
//  RemedyListTableViewController.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 06/07/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyListTableViewController.h"
#import "RemedyItem.h"
#import "RemedyViewControllerExt.h"

@interface RemedyListTableViewController ()

@end

@implementation RemedyListTableViewController

@synthesize filteredRemedyList;
@synthesize remedySearchBar;
@synthesize remedyList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Initialize table data
    
    remedyList = [NSArray arrayWithObjects:
                  [RemedyItem createRemedyListItem:@"1" description:@"chocolate bar chocolate chip dark chocolate ollipop" areaID:@"area1" status:@"New" assignedTo:@""],
                  [RemedyItem createRemedyListItem:@"2" description:@"chocolate chip" areaID:@"area1" status:@"New" assignedTo:@""],
                  [RemedyItem createRemedyListItem:@"3" description:@"dark chocolate" areaID:@"area1" status:@"Open" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"4" description:@"lollipop" areaID:@"area2" status:@"Open" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"5" description:@"candy cane" areaID:@"area2" status:@"New (re-assign)" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"6" description:@"jaw breaker" areaID:@"area3" status:@"Open" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"6" description:@"caramel" areaID:@"area3" status:@"Fixed" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"7" description:@"sour chew" areaID:@"area3" status:@"Test Not Ok" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"8" description:@"peanut butter cup" areaID:@"area5" status:@"No reproduce" assignedTo:@"Kasper Odgaard"],
                  [RemedyItem createRemedyListItem:@"9" description:@"gummi bear" areaID:@"area5" status:@"Closed" assignedTo:@"Kasper Odgaard"], nil];
    
    // Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    self.filteredRemedyList = [NSMutableArray arrayWithCapacity:[remedyList count]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredRemedyList count];
    } else {
        return [remedyList count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"listElementIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    RemedyItem *item;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        item = [filteredRemedyList objectAtIndex:indexPath.row];
    } else {
        item = [remedyList objectAtIndex:indexPath.row];
    }

    NSString *textLabel = [NSString stringWithFormat:@"#%@ %@", item.id,
                           item.description];
    cell.textLabel.text = textLabel;
    NSString *detailTextLabel;
    if ([item.assignedTo isEqualToString:@""]) {
        detailTextLabel = [NSString stringWithFormat:@"Status: %@ Area: %@", item.status,
                           item.areaID];
    } else {
    detailTextLabel = [NSString stringWithFormat:@"Status: %@ Area: %@ Assigned to: %@", item.status,
                           item.areaID, item.assignedTo];
   
    }
     cell.detailTextLabel.text = detailTextLabel;
    
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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredRemedyList removeAllObjects];
    // Filter the array using NSPredicate
    if ([scope isEqualToString:@"Id"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id contains[c] %@",searchText];
        filteredRemedyList = [NSMutableArray arrayWithArray:[remedyList filteredArrayUsingPredicate:predicate]];

    } else if ([scope isEqualToString:@"Description"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.description contains[c] %@",searchText];
    
    //    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"description contains[c] %@",searchText];
      //  NSPredicate *p2 = [NSPredicate predicateWithFormat:@"id contains[c] %@",searchText];
    //NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[p1, p2]];
   //     NSPredicate *twoPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[p1, p2]];
    
        // Further filter the array with the scope
       
         filteredRemedyList = [NSMutableArray arrayWithArray:[remedyList filteredArrayUsingPredicate:predicate]];
    } else if([scope isEqualToString:@"Area"]) {
          NSPredicate *predicateArea = [NSPredicate predicateWithFormat:@"areaID contains[c] %@",searchText];
         filteredRemedyList = [NSMutableArray arrayWithArray:[remedyList filteredArrayUsingPredicate:predicateArea]];
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"showRemedy" sender:tableView];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqualToString:@"showRemedy"]) {
         
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         NSLog(@"prepareForSegue  %@ indexPath: %ld section; %ld", segue.identifier, (long)indexPath.row, (long)indexPath.section);
         UINavigationController *navigationController = segue.destinationViewController;
         RemedyViewControllerExt *dest = (RemedyViewControllerExt * )navigationController;
         RemedyItem *remedyItem;
          if(sender == self.searchDisplayController.searchResultsTableView) {
             remedyItem = [filteredRemedyList objectAtIndex:indexPath.row];
         } else {
             remedyItem = [remedyList objectAtIndex:indexPath.row];
         }
         dest.remedyItem = remedyItem;
     }

 }


@end
