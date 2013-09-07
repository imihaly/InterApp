//
//  NSInvocation+IAHelper.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (IAHelper)

+ (NSInvocation *)invocationWithSelector:(SEL)selector;
+ (NSInvocation *)invocationWithSelector:(SEL)selector andArguments:first, ... NS_REQUIRES_NIL_TERMINATION;
+ (NSInvocation *)invocationWithInvocation:(NSInvocation *)invocation;

@end
