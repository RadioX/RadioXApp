//
//  xActivityViewController.h
//  RadioX
//
//  Created by witawat wanamonthon on 10/20/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableDictionary *jsonDict;
    NSMutableArray *jsonArray;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;

@end
