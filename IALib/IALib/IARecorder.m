//
//  IARecorder.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <objc/runtime.h>

#import "IARecorder.h"
#import "IAHelper.h"
#import "NSInvocation+IAHelper.h"

@interface IARecorder()
@property(nonatomic, strong) NSMutableArray *recordedInvocations;
@end

@implementation IARecorder

- (id)init {
	self.recordedInvocations = [NSMutableArray arrayWithCapacity:0];
	return self;
}

- (NSArray *)invocations {
	return [NSArray arrayWithArray:self.recordedInvocations];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
	NSInvocation *copiedInvocation = [NSInvocation invocationWithInvocation:invocation];
	[self.recordedInvocations addObject:copiedInvocation];
	[invocation setReturnValue:(void *)&self];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [IAHelper signatureForSelector:sel];
}

@end
