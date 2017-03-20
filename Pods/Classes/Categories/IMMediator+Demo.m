//
//  IMMediator+Demo.m
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import "IMMediator+Demo.h"

NSString * const kIMMediatorDemoTarget = @"TargetDemo";
NSString * const kIMMediatorActionShowAlert = @"showAlert";
NSString * const kIMMediatorActionCell = @"cell";
NSString * const kIMMediatorActionConfigCell = @"configCell";


@implementation IMMediator (Demo)

- (UIViewController *)gotoDemoViewController:(NSDictionary *)dictionary {
    
    UIViewController *viewController = [self performTarget:kIMMediatorDemoTarget
                                                    action:@"Action_gotoDemoViewController"
                                                    params:dictionary
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

/**
 提示弹框
 */
- (void)Mediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction {
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    [self performTarget:kIMMediatorDemoTarget
                 action:kIMMediatorActionShowAlert
                 params:paramsToSend
      shouldCacheTarget:NO];
}

/**
 生成特定的cell,可以使用缓存
 */
- (UITableViewCell *)Mediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView {
    return [self performTarget:kIMMediatorDemoTarget
                        action:kIMMediatorActionCell
                        params:@{
                                 @"identifier":identifier,
                                 @"tableView":tableView
                                 }
                        shouldCacheTarget:YES];
}

/**
 配置cell
 */
- (void)Mediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath {
    [self performTarget:kIMMediatorDemoTarget
                 action:kIMMediatorActionConfigCell
                 params:@{
                          @"cell":cell,
                          @"title":title,
                          @"indexPath":indexPath
                          }
      shouldCacheTarget:YES];
}

@end
