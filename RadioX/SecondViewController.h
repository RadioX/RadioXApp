//
//  SecondViewController.h
//  RadioX
//
//  Created by witawat wanamonthon on 10/14/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableDictionary *jsonDict;
    NSMutableArray *jsonArray;
    __weak IBOutlet UITableView *TableData;
}


@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;

@end
