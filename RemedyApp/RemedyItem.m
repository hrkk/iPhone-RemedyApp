//
//  RemedyItem.m
//  RemedyApp
//
//  Created by Kasper Odgaard on 10/06/15.
//  Copyright (c) 2015 Kasper Odgaard. All rights reserved.
//

#import "RemedyItem.h"

@implementation RemedyItem

@synthesize id;
@synthesize description;
@synthesize areaID;
@synthesize machineID;
@synthesize errorTypeID;
@synthesize image;
@synthesize status;
@synthesize assignedTo;

- (id) initWithDictionary:(NSDictionary *) dict{
    if (self = [super init]) {
        self.id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
        self.description = [dict objectForKey:@"description"];
        // get status
        NSDictionary *statusDict =[dict objectForKey:@"status"];
        NSDictionary *areaDict =[dict objectForKey:@"area"];
        NSDictionary *errorTypeDict =[dict objectForKey:@"errorType"];
        NSDictionary *machineDict =[dict objectForKey:@"machine"];
        
        NSLog(@"statusDict %@", statusDict );
        self.status = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [statusDict objectForKey:@"id"]] text:[statusDict objectForKey:@"displayText"]];
        self.areaID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [areaDict objectForKey:@"id"]] text:[areaDict objectForKey:@"displayText"]];
        self.errorTypeID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [errorTypeDict objectForKey:@"id"]] text:[errorTypeDict objectForKey:@"displayText"]];
        self.machineID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [machineDict objectForKey:@"id"]] text:[machineDict objectForKey:@"displayText"]];
        
        //SelectItem *item = [[SelectItem alloc] initWithDictionary:statusDict];
        //NSLog(@" status id  %@ text %@" ,item.id, item.text);
        
       //   SelectItem *item = [[SelectItem alloc] initWithDictionary:selectItem];
    }
    return self;
}

- (id) initWithDictionary2:(NSDictionary *) dict{
    if (self = [super init]) {
        self.id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
        self.description = [dict objectForKey:@"description"];
        // get status
        NSDictionary *statusDict =[dict objectForKey:@"status"];
        NSDictionary *areaDict =[dict objectForKey:@"area"];
        NSDictionary *errorTypeDict =[dict objectForKey:@"errorType"];
        NSDictionary *machineDict =[dict objectForKey:@"machine"];
       
         NSString *photoAsStr =  [NSString stringWithFormat:@"%@", [dict objectForKey:@"photo"]];
        
        const char *utfString = [photoAsStr UTF8String];
        
        NSData *myData = [NSData dataWithBytes: utfString length: strlen(utfString)];

       // [NSData dataWithBytes:<#(nullable const void *)#> length:<#(NSUInteger)#>
        
        NSLog(@"statusDict %@", statusDict );
        self.status = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [statusDict objectForKey:@"id"]] text:[statusDict objectForKey:@"displayText"]];
        self.areaID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [areaDict objectForKey:@"id"]] text:[areaDict objectForKey:@"displayText"]];
        self.errorTypeID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [errorTypeDict objectForKey:@"id"]] text:[errorTypeDict objectForKey:@"displayText"]];
        self.machineID = [SelectItem createSelectItem:[NSString stringWithFormat:@"%@", [machineDict objectForKey:@"id"]] text:[machineDict objectForKey:@"displayText"]];
      
          //NSURL *url = [NSURL URLWithString:[dict objectForKey:@"photo"]];
        
        //SelectItem *item = [[SelectItem alloc] initWithDictionary:statusDict];
        //NSLog(@" status id  %@ text %@" ,item.id, item.text);
        
        //   SelectItem *item = [[SelectItem alloc] initWithDictionary:selectItem];
//        data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    }
    return self;
}





+ (id)createRemedyListItem:(NSString *)id description:(NSString *)description areaID:(SelectItem*)areaID status:(SelectItem*)status assignedTo:(NSString*)assignedTo;
{
    RemedyItem *newRemedyItem = [[self alloc] init];
    newRemedyItem.id = id;
    newRemedyItem.description = description;
    newRemedyItem.areaID = areaID;
    newRemedyItem.status = status;
    newRemedyItem.assignedTo = assignedTo;
    return newRemedyItem;
}

@end
