//
//  IMMediator.m
//  IMMediator
//
//  Created by zhonglin xian on 14/03/2017.
//  Copyright © 2017 zhonglin xian. All rights reserved.
//

#import "IMMediator.h"
#import <objc/runtime.h>

@interface IMMediator()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation IMMediator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static IMMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[IMMediator alloc] init];
    });
    return mediator;
}

- (id)viewControllerWithJson:(NSDictionary *)dictionary {
    return [self viewControllerWithJson:dictionary shouldCachetarget:NO];
}

- (id)viewControllerWithJson:(NSDictionary *)dictionary shouldCachetarget:(BOOL)shouldCacheTarget {
    NSString *targetName = dictionary[@"target"];
    NSString *actionName = dictionary[@"action"];
    NSDictionary *jsonContent = dictionary[@"data"];
    return [self performTarget:targetName action:actionName params:jsonContent shouldCacheTarget:shouldCacheTarget];
}

/*
 scheme://[target]/[action]?[params]
 url sample:
 aaa://targetA/actionB?id=1234
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params shouldCacheTarget:NO];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    //如果没有传参的:,主动加入
    if ([actionName rangeOfString:@":"].location == NSNotFound) {
        actionName = [actionName stringByAppendingString:@":"];
    }
    Class targetClass;
    
    NSObject *target = self.cachedTarget[targetName];
    if (target == nil) {
        targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionName);
    
    if (target == nil) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return nil;
    }
    
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
    return nil;
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end

