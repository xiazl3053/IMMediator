//
//  IMMediator.h
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
    组件化基类
    可以通过调用ViewControllerWithJson:传入json，方式获取vc
    json格式:{@"target":@"MouduleA",@"action":@"MouduleA_Method",@"data":@{}}
    也可以通过categories的方式,调用-(id)performTarget:(NSString *)targetName 
                                           action:(NSString *)actionName 
                                           params:(NSDictionary *)params 
                                shouldCacheTarget:(BOOL)shouldCacheTarget,
    其中的targetName,组合成Moudule中的Targets类,actionName为Targets类的方法
    Target类名可以直接使用Json传输，或者通过增加前缀生成固定的方式:比如json中传入   action:Demo,类则是  TargetDemo
    Target类中实现具体的actionName的方法,相关的vc文件导入由Target类管理
    json中传输的对象，不仅仅只限于字符串，亦可是其他的对象,block,UIImage,Model,Cell...
 */
@interface IMMediator : NSObject

+ (id)sharedInstance ;

/**根据json内容转换成target
 target:组合成类,可以直接组合成Target类名，全部在json中串取，也可以直接在performTarget方法中去设置
 action:target类的方法
 其余target类某个方法需要的内容
 */
- (id)viewControllerWithJson:(NSDictionary *)dictionary;
//是否缓存
- (id)viewControllerWithJson:(NSDictionary *)dictionary shouldCachetarget:(BOOL)shouldCacheTarget;

/**
 远程APP调用入口
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion;

/**
 本地组件调用接口
 @param targetName Moudule文件夹中的类名组合
 @param actionName 方法
 @param params 参数,如果是复杂参数，使用json组装
 @param shouldCacheTarget 是否缓冲
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 释放缓冲
 @param targetName <#targetName description#>
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;


@end
