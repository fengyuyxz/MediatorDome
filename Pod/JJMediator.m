//
//  JJMediator.m
//  middlewareDome
//
//  Created by yanxuezhou on 2017/4/26.
//  Copyright © 2017年 yanxuezhou. All rights reserved.
//

#import "JJMediator.h"
#import "NotModleController.h"
@implementation JJMediator
+ (instancetype)sharedInstance{
    static JJMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[JJMediator alloc] init];
    });
    return mediator;
}
-(id)performURL:(NSURL *)url withCallBlock:(void(^)(NSDictionary *result))block{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    if (block) {
        [params setObject:block forKey:@"callBack"];
    }
    
    //后期 可加名字 参数适配
    NSString *actionName = [params objectForKey:@"actionName"];
    
    NSString *targetName =  [params objectForKey:@"targetName"];

    
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:targetName actionName:actionName withParams:params];
    
    
//    if (block) {
//        if (result) {
//            block(@{@"result":result});
//        } else {
//            block(nil);
//        }
//    }
    return result;

    
    
}
-(id)performTarget:(NSString *)targetName actionName:(NSString *)actionName withParams:(NSDictionary *)param{
    
    //
    NSString *targetClassString=[NSString stringWithFormat:@"Target_%@",targetName];
    NSString *actionString=[NSString stringWithFormat:@"action_%@:",actionName];
    Class targetClass=NSClassFromString(targetClassString);
    id target=[[targetClass alloc]init];
    SEL action = NSSelectorFromString(actionString);
    NotModleController *notContorller=[[NotModleController alloc]init];
    if (target==nil) {
        //无请求对象处理，
        
        return notContorller;
    }
    if ([target respondsToSelector:action]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
           return [target performSelector:action withObject:param];
        
#pragma clang diagnostic pop
        
    }else{
        // 有可能target是Swift对象
        actionString = [NSString stringWithFormat:@"Action_%@WithParams:", actionName];
        action = NSSelectorFromString(actionString);
        if ([target respondsToSelector:action]) {
          
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
                return [target performSelector:action withObject:param];
#pragma clang diagnostic pop
            
        }else{
            SEL action = NSSelectorFromString(@"notFound:");
            if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                return [target performSelector:action withObject:param];
#pragma clang diagnostic pop
            } else {
                // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
                return notContorller;
            }
        }
        
    }
    
    return nil;
}
@end
