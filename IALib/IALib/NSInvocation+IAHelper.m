//
//  NSInvocation+IAHelper.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "NSInvocation+IAHelper.h"
#import "IAHelper.h"
#import <stdarg.h>

@implementation NSInvocation (IAHelper)

+ (NSInvocation *)invocationWithSelector:(SEL)selector {
	NSMethodSignature *signature = [IAHelper signatureForSelector:selector];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setSelector:selector];
	[invocation setTarget:nil];
	return invocation;
}

+ (NSInvocation *)invocationWithSelector:(SEL)selector andArguments:first, ... {
	NSInvocation *invocation = [self invocationWithSelector:selector];
	
	va_list args;
    va_start(args, first);
	int idx = 2;
    for (id arg = first; arg != nil; arg = va_arg(args, id)) {
		[invocation setArgument:(void *)&arg atIndex:idx];
		idx++;
    }
    va_end(args);
	return invocation;
}

+ (NSInvocation *)invocationWithInvocation:(NSInvocation *)invocation {
	SEL selector = invocation.selector;
	NSInvocation *ret = [NSInvocation invocationWithSelector:selector];
	[ret retainArguments];
	for(int idx = 2; idx < invocation.methodSignature.numberOfArguments; idx++) {
		__unsafe_unretained id arg;
		[invocation getArgument:&arg atIndex:idx];
		[ret setArgument:&arg atIndex:idx];
	}
	return ret;
}

@end
