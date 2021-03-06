//
//  SecondViewController.m
//  RadioX
//
//  Created by witawat wanamonthon on 10/14/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "SBJson.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://www.iloveradiox.com/json/xnews"];
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    [self.logoOutlet setTitleView:imageView];
    NSString *jsonString = [self performStoreRequestWithURL:url];
    NSDictionary *responseDict = [jsonString JSONValue];
    jsonDict = [[NSMutableDictionary alloc] initWithDictionary:responseDict copyItems:YES];
    NSLog(@"%@",jsonDict);
    int i = 0;
    while (i < [responseDict count]) {
        UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"thumbnail"]]]]];
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(tempImage) forKey:[NSString stringWithFormat:@"imageFor%d",i]];
        i++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jsonDict count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *imageViews = (UIImageView*)[cell viewWithTag:1];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"imageFor%d",indexPath.row]];
    [imageViews setImage:[UIImage imageWithData:imageData]];
    UILabel *title = (UILabel*)[cell viewWithTag:2];
    [title setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"title"]]];
    UILabel *intro = (UILabel*)[cell viewWithTag:3];
    [intro setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"intro"]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    [detailView setTextString:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] objectForKey:@"content"]]];
    [self.navigationController pushViewController:detailView animated:YES];
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
