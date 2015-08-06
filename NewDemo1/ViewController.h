//
//  ViewController.h
//  NewDemo1
//
//  Created by 张良 on 15/8/6.
//  Copyright (c) 2015年 张良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *markArr;

@end

