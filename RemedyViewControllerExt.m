//
//  RemedyViewControllerExt.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 21/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyViewControllerExt.h"
#import "DetailSelectTableViewController.h"
#import "ComposeViewController.h"
#import "LogItem.h"
#import "ContactInfoViewController.h"
#import "CameraViewController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f // bredden af description
#define CELL_CONTENT_MARGIN 20.0f

@interface RemedyViewControllerExt (){
    NSArray *recipes;
    NSArray *problems;
    NSArray *contactInfos;
    NSArray *logs;
    
    NSMutableArray *logArray;
}

@end

@implementation RemedyViewControllerExt

@synthesize remedyItem;

- (IBAction)unwindRemedy:(UIStoryboardSegue *)segue {
    NSLog(@"unwindToList metode in RemedyViewControllerExt");
    DetailSelectTableViewController *source = [segue sourceViewController];
   remedyItem = source.remedyItem;
    if(remedyItem != nil) {
        NSLog(@"remedyItem.areaID=%@",remedyItem.areaID);
        [self.tableView reloadData];
    }
   // item = source.toDoItem;
   // NSLog(@"  value=%@",item);
   // if (item != nil) {
        // change index 0
        //   recipes[0] = item;
    //    [self.tableView reloadData];
   // }
}

- (IBAction)unwindRemedyDescription:(UIStoryboardSegue *)segue {
     NSLog(@"unwindRemedyDescription metode in RemedyViewControllerExt");
     ComposeViewController *source = [segue sourceViewController];
     NSLog(@"unwindRemedyDescription source.description %@ remedyItem.description %@ in RemedyViewControllerExt", source.description,remedyItem.description);
    if (source.description != nil) {
        remedyItem.description =source.description;
        if ([remedyItem.description isEqualToString:@""])
             remedyItem.description = @"No description";
        [self.tableView reloadData];
    }
}

- (IBAction)unwindRemedyPhoto:(UIStoryboardSegue *)segue {
    NSLog(@"unwindRemedyPhoto metode in RemedyViewControllerExt");
    CameraViewController *source = [segue sourceViewController];
     if (source.description != nil) {
        remedyItem.image = source.selectImage;
        [self.tableView reloadData];
     }
    
      // item = source.toDoItem;
    // NSLog(@"  value=%@",item);
    // if (item != nil) {
    // change index 0
    //   recipes[0] = item;
    //    [self.tableView reloadData];
    // }
}

/*

- (void)viewWillAppear: (BOOL) animated {
    NSLog(@"viewWillAppear metode in RemedyViewControllerExt");
    [self.tableView reloadData];
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Initialize table data
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    problems = [NSArray arrayWithObjects:@"Area", @"Machine", @"Type of error", nil];
    contactInfos = [NSArray arrayWithObjects:@"Name", @"Email", @"Phone number", nil];
    logs = [NSArray arrayWithObjects:@"Created", @"Assign to XXX", @"Reassignment", nil];
    
    
    
    
    
   logArray = [[NSMutableArray alloc] init];
    // add some data to the array
    LogItem *logItem1 = [[LogItem alloc] init];
    logItem1.username = @"Kasper O";
    logItem1.status = @"Created";
    logItem1.displayDateTime =@"5h";
    
    [logArray addObject:logItem1];
    
    LogItem *logItem2 = [[LogItem alloc] init];
    logItem2.username = @"Jørgen Jørgsen";
    logItem2.status = @"Assigned";
    logItem2.displayDateTime =@"1d";
    
     [logArray addObject:logItem2];
    
   
    
    // create empty remedyItem
    if(remedyItem==nil) {
        remedyItem = [[RemedyItem alloc] init];
        remedyItem.description = @"No description";
        // Navigation Title
        self.navigationItem.title=  @"Create";
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveItem)];
        
        self.navigationItem.rightBarButtonItem = saveButton;
    } else {
        NSString *title = [NSString stringWithFormat:@"#%@", remedyItem.id];
        self.navigationItem.title=  title;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [problems count];
    } else  if(section == 1){
        return 1;
    } else  if(section == 2){
         return 1;
    } else if(section == 3) {
        return [logArray count];
    } else if(section == 4) {
    }
  
    return 2;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:   (NSInteger)section
{
    if (section == 0) {
        return @"Problem";
    } else if(section == 1) {
        return @"Short description";
    } else if(section == 2) {
        return @"Picture";
    } else if(section == 3) {
        return @"Log";
    } else {
        return @"Log";
    }
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:   (NSInteger)section
 {
 return @"Footer";
 }
 */

// skjuler footer til section
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // if (section == 0)
    //     return 1.0f;
    return 32.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RemedyCell";
    static NSString *customCellTableIdentifier = @"CustomCell";
    static NSString *customImageCellTableIdentifier = @"CustomImageCell";
    static NSString *remedyDescriptionCellTableIdentifier = @"RemedyDescriptionCell";
    static NSString *logCellTableIdentifier = @"LogCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = [problems objectAtIndex:indexPath.row];
        // Area
        if (indexPath.row == 0) {
             cell.detailTextLabel.text = remedyItem.areaID;
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = remedyItem.machineID;
        } else if (indexPath.row == 2) {
            cell.detailTextLabel.text = remedyItem.errorTypeID;
        }
        else {
            cell.detailTextLabel.text = @"buh";
        }
    } else if(indexPath.section == 1) {
        UITableViewCell *descriptionCell = [tableView dequeueReusableCellWithIdentifier:remedyDescriptionCellTableIdentifier];
        descriptionCell.textLabel.numberOfLines = 0;
        descriptionCell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
      // descriptionCell.textLabel.text = @"jdnjc dcbcdh cdc dhc dc dc dc djnc djnc dnc dc c sc nsjddd ks kasper Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Kasper Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat K nulla jncdjscndjdcndjscn dcndjcndjsc sdc dsnc dnc d cd cdn cjdkjdncjdfnvdfjv sidste";
        descriptionCell.textLabel.text =  remedyItem.description;
        if ([descriptionCell.textLabel.text isEqualToString:@"No description"]) {
            descriptionCell.textLabel.font = [UIFont italicSystemFontOfSize:16.0];
        } else {
            descriptionCell.textLabel.font = [UIFont systemFontOfSize:16.0];
        }
        
        cell = descriptionCell;
    } else if(indexPath.section == 2) {
        /*
        UITableViewCell *customerCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
       
        UIImageView *pic = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"glad.jpg"]];
        pic.center = CGPointMake(cell.contentView.bounds.size.width / 2 , 60);
        pic.contentMode = UIViewContentModeScaleAspectFit;
        customerCell.selectionStyle = UITableViewCellSelectionStyleGray;
        [customerCell.contentView addSubview:pic];
        
        return customerCell;
        */
        
     //
        UITableViewCell *customerCell = [tableView dequeueReusableCellWithIdentifier:customImageCellTableIdentifier];
       UIImageView *problemPicImageView = (UIImageView *)[customerCell viewWithTag:1000];
       UILabel *problemPicLabel = (UILabel *)[customerCell viewWithTag:1001];
        
        if(remedyItem.image ==nil){
         problemPicLabel.hidden = NO;
        } else {
            problemPicLabel.hidden = YES;
        }

        
        UIImage *orgImg =  remedyItem.image; // [UIImage imageNamed:@"glad.jpg"];
        // resize 1
        /*
        CGRect rect = CGRectMake(0,0,175,175);
        UIGraphicsBeginImageContext( rect.size );
        [orgImg drawInRect:rect];
        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(picture1);
        UIImage *img=[UIImage imageWithData:imageData];
        */
        // resize 2
        
        /*
        CGRect rect = CGRectMake(0,0,175,175);
        CGSize newSize =rect.size;
        CGFloat scale = [[UIScreen mainScreen]scale];
        //You can remove the below comment if you dont want to scale the image in retina   device .Dont // forget to comment UIGraphicsBeginImageContextWithOptions
        //UIGraphicsBeginImageContext(newSize);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [orgImg drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        */
        
        // resize 3
        
        UIImage *myResizedImage = [self imageWithImage:orgImg
                                                scaledToMaxWidth:175
                                                       maxHeight:175];
        problemPicImageView.image =myResizedImage;
        
        // sørger for at hele billede kan ses
       //   problemPicImageView.contentMode = UIViewContentModeCenter;
        
       //  problemPicImageView.contentMode = UIViewContentModeScaleAspectFit;

        cell = customerCell;
       // cell.textLabel.text = @"Show large picture";
   // 2    cell.imageView.image = [UIImage imageNamed:@"glad.jpg"];
   // 3     cell.textLabel.text = @"Click for large pic";
   // 4     cell.detailTextLabel.text = @"";
        return cell;
    }  else if(indexPath.section == 3) {
        UITableViewCell *logCell = [tableView dequeueReusableCellWithIdentifier:logCellTableIdentifier];
        LogItem *logItem = [logArray objectAtIndex:indexPath.row];
        logCell.textLabel.text = logItem.username;
        NSString *detailTextLabel = [NSString stringWithFormat:@"%@ - %@", logItem.status,
                               logItem.displayDateTime];
        logCell.detailTextLabel.text = detailTextLabel;
        cell = logCell;
    } else if(indexPath.section == 5) {
        
    }
    return cell;
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self imageWithImage:image scaledToSize:newSize];
}
 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
      if (indexPath.section == 1) {  // the cell you want to be dynamic
        
          NSString *text =  remedyItem.description;
// @"jdnjc dcbcdh cdc dhc dc dc dc djnc djnc dnc dc c sc nsjddd ks kasper Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Kasper Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat K nulla jncdjscndjdcndjscn dcndjcndjsc sdc dsnc dnc d cd cdn cjdkjdncjdfnvdfjv sidste";
          
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        CGFloat height = MAX(size.height, 44.0f);
         if ([remedyItem.description isEqualToString:@"No description"])
             return 44;
        return height + (CELL_CONTENT_MARGIN * 2);
      } else  if (indexPath.section == 2) {
          // picture height
          if(remedyItem.image ==nil)
              return 44;
          else
              return 188.0f;
      } else {
        return 44; // return normal cell height
    }
}



// styrer hvilker view man skal føres hentil
// når der er mere en 2 forskellige view man kan føres hent til ved klik i en tableViewCell
// så kan ctrl-drag med seque fra cell ikke anvendes. Seque skal laves på øverste view niveau og
// så routes man videre i denne metode.
// http://www.sundoginteractive.com/sunblog/posts/performing-segues-in-ios-programmatically

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueName = nil;
    
    if(indexPath.section ==0) {
        segueName = @"showRemedySelect";
    } else  if(indexPath.section == 1) {
        segueName = @"showRemedyDecription";
    } else  if(indexPath.section == 2) {
        segueName = @"showImage";
    }else  if(indexPath.section == 3) {
        segueName = @"showContactInfo";
    }
    
    [self performSegueWithIdentifier: segueName sender: self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showRemedySelect"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"prepareForSegue  %@ indexPath: %ld section; %ld", segue.identifier, (long)indexPath.row, (long)indexPath.section);
        UINavigationController *navigationController = segue.destinationViewController;
        DetailSelectTableViewController *dest = (DetailSelectTableViewController * )navigationController;
        if(indexPath.section==0 && indexPath.row ==0)
            dest.problemType = @"AREA";
        else if(indexPath.section==0 && indexPath.row ==1)
            dest.problemType = @"MACHINE";
        else if(indexPath.section==0 && indexPath.row ==2)
            dest.problemType = @"ERROR_TYPE";
        dest.remedyItem = remedyItem;
    }
    else if ([segue.identifier isEqualToString:@"showRemedyDecription"]) {
        NSLog(@"prepareForSegue indexPath: %@s", segue.identifier);
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"prepareForSegue indexPath: %@ %ld", segue.identifier, (long)indexPath.row);
        UINavigationController *navigationController = segue.destinationViewController;
        ComposeViewController *dest = (ComposeViewController * )navigationController;
        if ([remedyItem.description isEqualToString:@"No description"])
            dest.description = @"";
        else
            dest.description = remedyItem.description;
    }  else if ([segue.identifier isEqualToString:@"showImage"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        CameraViewController *dest = (CameraViewController * )navigationController;
        dest.remedyItem = remedyItem;
    }
    else if ([segue.identifier isEqualToString:@"showContactInfo"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ContactInfoViewController *dest = (ContactInfoViewController * )navigationController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LogItem *logItem = [logArray objectAtIndex:indexPath.row];
        dest.userId =logItem.userId;
    }  else if ([segue.identifier isEqualToString:@"showMenu"]) {
        NSLog(@"prepareForSegue showMenu");

    }
}

@end
