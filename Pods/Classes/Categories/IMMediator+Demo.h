//
//  IMMediator+Demo.h
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import "IMMediator.h"
#import <UIKit/UIKit.h>

@interface IMMediator (Demo)


/**
 普通跳转页面
 */
- (UIViewController *)gotoDemoViewController:(NSDictionary *)dictionary;

/**
 提示弹框
 */
- (void)Mediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;

/**
 生成特定的cell
 */
- (UITableViewCell *)Mediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView;

/**
 配置cell
 */
- (void)Mediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;

@end
