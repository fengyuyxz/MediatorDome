//
//  JJMediator.h
//  middlewareDome
//
//  Created by yanxuezhou on 2017/4/26.
//  Copyright © 2017年 yanxuezhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJMediator : NSObject
+ (instancetype)sharedInstance;
-(id)performURL:(NSURL *)url withCallBlock:(void(^)(NSDictionary *result))block;
-(id)performTarget:(NSString *)targetName actionName:(NSString *)actionName withParams:(NSDictionary *)param;
@end
