//
//  IAURLInvocationCoder.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <objc/runtime.h>
#import "IAURLInvocationCoder.h"
#import "IAHelper.h"
#import "NSInvocation+IAHelper.h"
#import <Foundation/Foundation.h>

@implementation IAURLInvocationCoder

- (id)encodeInvocations:(NSArray *)invocations {
	id JSONObject = [self JSONObjectFromInvocations:invocations];
	
	NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject
												   options:0
													 error:NULL];
	NSString *seq = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSString *encSeq = [seq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSMutableString *urlString = [NSMutableString stringWithFormat:@"seq=%@", encSeq];
	
	return urlString;
}

- (NSArray *)decodeInvocations:(id)encodedInvocations {
	NSRange range = [encodedInvocations rangeOfString:@"seq="];
	if(range.length == 0) return nil;
	NSString *encSeq = [encodedInvocations substringFromIndex:range.length];
	NSString *seq = [encSeq stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [seq dataUsingEncoding:NSUTF8StringEncoding];
	
	id JSONObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
	return [self invocationsFromJSONObject:JSONObject];
}

- (id)JSONObjectFromInvocations:(NSArray *)invocations {
	NSMutableArray *array = [NSMutableArray array];
	for(NSInvocation *invocation in invocations) {
		[array addObject:[self JSONObjectFromInvocation:invocation]];
	}
	return array;
}

- (NSArray *)invocationsFromJSONObject:(id)JSONObject {
	NSArray *array = (NSArray *)JSONObject;
	NSMutableArray *invocations = [NSMutableArray array];
	
	for(id JSONObj in array) {
		[invocations addObject:[self invocationFromJSONObject:JSONObj]];
	}
	return invocations;
}

- (id)JSONObjectFromInvocation:(NSInvocation *)invocation {
	NSMutableArray *array = [NSMutableArray array];
	
	SEL selector = invocation.selector;
	NSString *name = NSStringFromSelector(selector);
	[array addObject:name];
	
	NSMethodSignature *signature = invocation.methodSignature;
	
	for(int idx = 2; idx < signature.numberOfArguments; idx++) {
		__unsafe_unretained id param;
		[invocation getArgument:&param atIndex:idx];
		[array addObject:param];
	}
	
	return array;
}

- (NSInvocation *)invocationFromJSONObject:(id)JSONObject {
	NSArray *array = (NSArray *)JSONObject;
	NSString *selectorName = array[0];
	
	SEL selector = NSSelectorFromString(selectorName);
	NSInvocation *invocation = [NSInvocation invocationWithSelector:selector];
	
	NSMethodSignature *signature = invocation.methodSignature;
	for(int idx = 2; idx < signature.numberOfArguments; idx++) {
		id param = array[idx - 1];
		[invocation setArgument:&param atIndex:idx];
	}
	[invocation retainArguments];
	
	return invocation;
}

@end
