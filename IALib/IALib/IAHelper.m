//
//  IAHelper.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "IAHelper.h"

@implementation IAHelper

+ (NSString *)signatureStringForSelector:(SEL)selector {
	const char *name = sel_getName(selector);
	NSMutableString *sigstr = [NSMutableString stringWithFormat:@"@@:"];
	
	const char* p = name;
	while(*p) {
		if(*p == ':') {
			[sigstr appendString:@"@"];
		}
		p++;
	}
	
	return sigstr;
}

+ (NSMethodSignature *)signatureForSelector:(SEL)selector {
	NSString *signatureString = [self signatureStringForSelector:selector];
	const char *types = [signatureString cStringUsingEncoding:NSUTF8StringEncoding];
	return [NSMethodSignature signatureWithObjCTypes:types];
}

@end
