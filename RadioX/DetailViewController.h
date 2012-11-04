//
//  DetailViewController.h
//  RadioX
//
//  Created by witawat wanamonthon on 10/20/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
- (IBAction)backButtonPress:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webViews;
@property (nonatomic, retain) NSString *textString;
@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;
@end
