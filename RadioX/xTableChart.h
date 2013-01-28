//
//  xTableChart.h
//  RadioX
//
//  Created by witawat wanamonthon on 11/4/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xTableChart : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *tableData;
    NSMutableDictionary *jsonDict;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;

@end
