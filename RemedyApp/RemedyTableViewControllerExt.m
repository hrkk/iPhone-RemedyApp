//
//  RemedyViewControllerExt.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 21/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyTableViewControllerExt.h"
#import "DetailSelectTableViewController.h"
#import "ComposeViewController.h"
#import "LogItem.h"
#import "RemedyLog.h"
#import "ContactInfoViewController.h"
#import "CameraViewController.h"
#import "AFNetworking.h"
#import "Prefs.h"
#import "AppDataCache.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f // bredden af description
#define CELL_CONTENT_MARGIN 20.0f

@interface RemedyTableViewControllerExt (){
    NSArray *recipes;
    NSArray *problems;
    NSArray *contactInfos;
    NSArray *logs;
    
    BOOL isNewRemedy;
}

@end

@implementation RemedyTableViewControllerExt

@synthesize remedyItem;

- (IBAction)save:(id)sender {
     NSLog(@"save called");
   // UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"RemedyListID"];
  //  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
  //  [self.navigationController pushViewController:navi animated:YES];
}



- (IBAction)saveButtonAction:(id)sender {
    NSString *description = remedyItem.description;
    NSInteger idInt = [remedyItem.id intValue];
    
    NSInteger statusIdInt = [remedyItem.status.id intValue];
    NSInteger areaIdInt = [remedyItem.areaID.id intValue];
    NSInteger machineIdInt = [remedyItem.machineID.id intValue];
    NSInteger errorTypeIdInt = [remedyItem.errorTypeID.id intValue];
    NSNumber *remedyId = [NSNumber numberWithInt:idInt];
    NSNumber *statusId = [NSNumber numberWithInt:statusIdInt];
    NSNumber *areaId = [NSNumber numberWithInt:areaIdInt];
    NSNumber *machineId = [NSNumber numberWithInt:machineIdInt];
    NSNumber *errorTypeId = [NSNumber numberWithInt:errorTypeIdInt];
    
    
    NSString *byteArray = [UIImagePNGRepresentation( remedyItem.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    // get hardcoded image
    NSData *imageData = UIImageJPEGRepresentation(remedyItem.image, 0);
    
    //    NSData *imgData = UIImageJPEGRepresentation(remedyItem.image, 0);
    long imageBytes = (unsigned long)[imageData length];
    NSLog(@"Size of Image(bytes):%lu",imageBytes);
    
    //   NSLog(@"%@", byteArray);
    /*
     
     You can convert the UIImage to a NSData object and then extract the byte array from there. Here is some sample code:
     
     UIImage *image = [UIImage imageNamed:@"image.png"];
     NSString *byteArray = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     If you are using a PNG Image you can use the UIImagePNGRepresentation function as shown above or if you are using a JPEG Image, you can use the UIImageJPEGRepresentation function. Documentation is available on the UIImage Class Reference
     
     */
    
    
    
    
    NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              remedyId, @"id",
                              description, @"description",
                              statusId, @"statusId",
                              areaId, @"areaId",
                              machineId, @"machineId",
                              errorTypeId, @"errorTypeId",
                              nil];
    
    
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];

    
    
    NSLog(@"jsonDict: %@", jsonDict);
    
    
    //  @"http://localhost:8080/RemedyAdminApp/remedyRest/save"
    //  NSString *postUrl = @"http://localhost:8080/RemedyAdminApp/remedyRest/save";
    
    NSString *postUrl = nil;
    NSString *serverRoot = PREFS_SERVER_URL;
    
    NSString *authValue = [AppDataCache shared].authorization;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if(imageBytes >0) {
        if(isNewRemedy)
            postUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyRest/save"];
        else
            postUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyRest/updateImage"];
        [manager POST:postUrl parameters:jsonDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"head.jpg" mimeType:@"jpg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
             [self.activityIndicatorView stopAnimating];
            NSString *segueName = @"showList";
            [self performSegueWithIdentifier: segueName sender: self];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
             [self.activityIndicatorView stopAnimating];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Saving data on server'"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
        
    } else if(imageBytes == 0){
        if(isNewRemedy)
            postUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyRest/saveNoImage"];
        else
            postUrl = [NSString stringWithFormat:@"%@%@", serverRoot, @"remedyRest/updateNoImage"];
        [manager POST:postUrl parameters:jsonDict
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"JSON: %@", responseObject);
                   [self.activityIndicatorView stopAnimating];
                  NSString *segueName = @"showList";
                  [self performSegueWithIdentifier: segueName sender: self];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
                   [self.activityIndicatorView stopAnimating];
                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Saving data on server'"
                                                                      message:[error localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Ok"
                                                            otherButtonTitles:nil];
                  [alertView show];
              }];
    }
}

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
    recipes= [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    problems = [NSArray arrayWithObjects:@"Area", @"Machine", @"Type of error", nil];
    contactInfos = [NSArray arrayWithObjects:@"Name", @"Email", @"Phone number", nil];
    logs = [NSArray arrayWithObjects:@"Created", @"Assign to XXX", @"Reassignment", nil];
    
    // create empty remedyItem
    if(remedyItem==nil) {
        isNewRemedy = YES;
        remedyItem = [[RemedyItem alloc] init];
        remedyItem.id = nil;
        remedyItem.description = @"No description";
        remedyItem.areaID = [SelectItem createEmptySelectItem];
        remedyItem.machineID = [SelectItem createEmptySelectItem];
        remedyItem.errorTypeID = [SelectItem createEmptySelectItem];
        NSArray *statusList = [AppDataCache shared].statusList;
      
        remedyItem.status = statusList[0]; //[SelectItem createEmptySelectItem];
        // Navigation Title
        self.navigationItem.title=  @"Create";
    } else {
        isNewRemedy = NO;
        NSString *title = [NSString stringWithFormat:@"#%@", remedyItem.id];
        self.navigationItem.title =  title;
        NSString *serviceUrl = nil;
        NSString *serverRoot = PREFS_SERVER_URL;
        serviceUrl = [NSString stringWithFormat:@"%@%@%@", serverRoot, @"imageRest/showImage/", remedyItem.id];
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        remedyItem.image = [UIImage imageWithData:data];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
       return 1;
    } else if(section == 1){
        return [problems count];
    } else  if(section == 2){
        return 1;
    } else  if(section == 3){
        return 1;
    } else if(section == 4 && !isNewRemedy) {
        return [remedyItem.logs count];
    } else if(section == 5) {
    }
    
    return 2;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(isNewRemedy)
        return 4;
    else
        return 5;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:   (NSInteger)section
{
    if(section ==0) {
        return @"Status";
    } else if (section == 1) {
        return @"Problem";
    } else if(section == 2) {
        return @"Short description";
    } else if(section == 3) {
        return @"Picture";
    } else if(section == 4 && !isNewRemedy) {
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
        cell.textLabel.text = @"Status";
        cell.detailTextLabel.text= remedyItem.status.text;

    }
    
    else if(indexPath.section == 1) {
        cell.textLabel.text = [problems objectAtIndex:indexPath.row];
        // Area
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = remedyItem.areaID.text;
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = remedyItem.machineID.text;
        } else if (indexPath.row == 2) {
            cell.detailTextLabel.text = remedyItem.errorTypeID.text;
        }
        else {
            cell.detailTextLabel.text = @"buh";
        }
    } else if(indexPath.section == 2) {
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
    } else if(indexPath.section == 3) {
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
    }  else if(indexPath.section == 4) {
        UITableViewCell *logCell = [tableView dequeueReusableCellWithIdentifier:logCellTableIdentifier];
        RemedyLog *logItem = [remedyItem.logs objectAtIndex:indexPath.row];
        logCell.textLabel.text = logItem.statusChangeByName;
        NSString *detailTextLabel = [NSString stringWithFormat:@"%@ - %@", logItem.status,
                                     logItem.lastUpdated];
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
    if (indexPath.section == 2) {  // the cell you want to be dynamic
        
        NSString *text =  remedyItem.description;
        // @"jdnjc dcbcdh cdc dhc dc dc dc djnc djnc dnc dc c sc nsjddd ks kasper Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Kasper Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat K nulla jncdjscndjdcndjscn dcndjcndjsc sdc dsnc dnc d cd cdn cjdkjdncjdfnvdfjv sidste";
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        CGFloat height = MAX(size.height, 44.0f);
        if ([remedyItem.description isEqualToString:@"No description"])
            return 44;
        return height + (CELL_CONTENT_MARGIN * 2);
    } else  if (indexPath.section == 3) {
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
    
    if(indexPath.section ==0 || indexPath.section ==1) {
        segueName = @"showRemedySelect";
    } else  if(indexPath.section == 2) {
        segueName = @"showRemedyDecription";
    } else  if(indexPath.section == 3) {
        segueName = @"showImage";
    }else  if(indexPath.section == 4) {
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
            dest.problemType = @"STATUS";            
        else if(indexPath.section==1 && indexPath.row ==0)
            dest.problemType = @"AREA";
        else if(indexPath.section==1 && indexPath.row ==1)
            dest.problemType = @"MACHINE";
        else if(indexPath.section==1 && indexPath.row ==2)
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
        
        //     RemedyLog *logItem = [remedyItem.logs objectAtIndex:indexPath.row];
        
        
        
        RemedyLog *logItem = [remedyItem.logs objectAtIndex:indexPath.row];
        dest.userId =logItem.userId;
    }
    else if ([segue.identifier isEqualToString:@"showList"]) {
          NSLog(@"prepareForSegue showMenu");
    }
}

@end
