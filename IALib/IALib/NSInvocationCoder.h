//
//  NSInvocationCoder.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSInvocationCoder <NSObject>

- (id)encodeInvocations:(NSArray *)invocations;
- (NSArray *)decodeInvocations:(id)encodedInvocations;

@end