//
//  NSString+URLEncoding.m
//  IALib
//
//  Created by Imre Mihaly on 9/7/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)URLEncodedString {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																				 (__bridge CFStringRef)self,
																				 NULL,
																				 CFSTR("!*'();:@&=+$,/?%#[]"),
																				 kCFStringEncodingUTF8));
}

- (NSString *)URLDecodedString {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
																								 (__bridge CFStringRef)self,
																								 CFSTR(""),
																								 kCFStringEncodingUTF8));
}

@end
