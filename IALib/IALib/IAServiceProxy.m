//
//  IAServiceProxy.m
//  IALib
//
//  Created by Imre Mihaly on 9/7/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "IAServiceProxy.h"

@interface IAServiceProxy()
@property(nonatomic, assign) BOOL invoked;
@end

@implementation IAServiceProxy

- (void)dealloc {
	if(!self.invoked) [self invoke];
}

- (void)invoke {
	self.invoked = YES;
	[self.handler invoke:self];
}

@end
