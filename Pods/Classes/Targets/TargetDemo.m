//
//  DemoAction.m
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import "TargetDemo.h"
#import "TestViewController.h"

@implementation TargetDemo

- (UIViewController* )Action_gotoDemoViewController:(NSDictionary *)dictionary {
    TestViewController *testVc = [[TestViewController alloc] init];
    testVc.title = @"Test";
    testVc.jsonData = dictionary;
    return testVc;
}

- (UITableViewCell *)Action_cell:(NSDictionary *)params {
    UITableView *tableView = params[@"tableView"];
    NSString *identifier = params[@"identifier"];
    // 这里的TableViewCell的类型可以是自定义的
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)Action_configCell:(NSDictionary *)params {
    NSString *title = params[@"title"];
    NSIndexPath *indexPath = params[@"indexPath"];
    UITableViewCell *cell = params[@"cell"];
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%ld", title, (long)indexPath.row];
    //使用json格式绑定cell数据,去掉model方式
    //  if ([cell isKindOfClass:[XXXXXCell class]]) {
    //     cell 封装
    //  }
    
    return nil;
}

@end
