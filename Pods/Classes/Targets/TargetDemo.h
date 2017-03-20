//
//  DemoAction.h
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TargetDemo : NSObject

- (UIViewController *)Action_gotoDemoViewController:(NSDictionary *)dictionary;

/**
 配置cell
 */
- (id)Action_configCell:(NSDictionary *)params;

/**
 生成cell
 */
- (UITableViewCell *)Action_cell:(NSDictionary *)params;

@end
