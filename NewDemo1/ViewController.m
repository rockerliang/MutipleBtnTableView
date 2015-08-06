//
//  ViewController.m
//  NewDemo1
//
//  Created by 张良 on 15/8/6.
//  Copyright (c) 2015年 张良. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    
    _tableView.separatorEffect = blurEffect;
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 15; i ++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _markArr = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 1. 更新数据
        
        [_dataArray removeObjectAtIndex:indexPath.row];
        
        
        
        // 2. 更新UI
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath

{
    
    // 1. 更新数据
    
    NSString *title = _dataArray[sourceIndexPath.row];
    
    [_dataArray removeObject:title];
    
    [_dataArray insertObject:title atIndex:destinationIndexPath.row];
    
    
    
    // 2. 更新UI
    
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    
}








- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // 添加一个删除按钮
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
        
        
        
        // 1. 更新数据
        
        [_dataArray removeObjectAtIndex:indexPath.row];
        
        // 2. 更新UI
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    
    
        // 删除一个置顶按钮
    
        UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标记" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    
            NSLog(@"点击了置顶");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"111" message:@"22" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
    
    
    
            // 1. 更新数据
    
          //  [_dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
    
    
    
            // 2. 更新UI
    
          //  NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    
          //  [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
            [_markArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
            [tableView reloadData];
    
        }];
        topRowAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"123.png"]];
    for (int i = 0; i < _markArr.count; i ++) {
        if(indexPath.row == [_markArr[i] integerValue])
        {
            topRowAction.backgroundColor = [UIColor yellowColor];
        }
    }
    
    
    
    
    // 添加一个更多按钮
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了更多");
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        moreRowAction.backgroundColor = [UIColor yellowColor];
        
    }];
    
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    
    
    return @[deleteRowAction,moreRowAction,topRowAction];
    
}


@end
