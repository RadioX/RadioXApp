//
//  xTableChart.m
//  RadioX
//
//  Created by witawat wanamonthon on 11/4/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import "xTableChart.h"
#import "SBJson.h"

@interface xTableChart ()

@end

@implementation xTableChart

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.iloveradiox.com/json/chart"];
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    [self.logoOutlet setTitleView:imageView];
    NSString *jsonString = [self performStoreRequestWithURL:url];
    NSDictionary *responseDict = [jsonString JSONValue];
    jsonDict = [[NSMutableDictionary alloc] initWithDictionary:responseDict copyItems:YES];
    int i = 0;
    while (i < [responseDict count]) {
        UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"image"]]]]];
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(tempImage) forKey:[NSString stringWithFormat:@"imageForTableChart%d",i]];
        i++;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jsonDict count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    UILabel *rank = (UILabel*)[cell viewWithTag:1];
    [rank setText:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    UIImageView *imageViews = (UIImageView*)[cell viewWithTag:2];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"imageForTableChart%d",indexPath.row]];
    [imageViews setImage:[UIImage imageWithData:imageData]];
    UILabel *song = (UILabel*)[cell viewWithTag:3];
    [song setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"song"]]];
    UILabel *artist = (UILabel*)[cell viewWithTag:4];
    [artist setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"artist"]]];
    UIImageView *statusImage = (UIImageView*)[cell viewWithTag:5];
    NSString *statusString = [NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"status"]];
    if ([statusString isEqualToString:@"down"]) {
        [statusImage setImage:[UIImage imageNamed:@"down.png"]];
    }else if([statusString isEqualToString:@"up"]) {
        [statusImage setImage:[UIImage imageNamed:@"up.png"]];
    }else if([statusString isEqualToString:@"stable"]) {
        [statusImage setImage:[UIImage imageNamed:@"stable.png"]];
    }else if([statusString isEqualToString:@"new"]) {
        [statusImage setImage:[UIImage imageNamed:@"new.png"]];
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        return nil;
    }
    return resultString;
}
@end
