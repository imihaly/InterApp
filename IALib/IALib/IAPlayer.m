//
//  IAPlayer.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "IAPlayer.h"

@interface IAPlayer()

@property(nonatomic, assign) id target;

@end

@implementation IAPlayer

- (id)initWithTarget:(id)target {
	self = [super init];
	if(self) {
		self.target = target;
	}
	return self;
}

- (id)playInvocations:(NSArray *)invocations {
	__unsafe_unretained id target = self.target;
	for(NSInvocation *invocation in invocations) {
		[invocation invokeWithTarget:target];
		[invocation getReturnValue:(void *)&target];
	}
	return target;
}

@end
