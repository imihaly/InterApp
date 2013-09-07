//
//  IAURLInvocationCoder.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Encodes a set of invocations into a url-encoded string which can be passed as argument for a GET request.
 Each invocation has to have object arguments and must return an object. Also, each argument must be serializable using NSJSONSerialization.
 */
@interface IAURLInvocationCoder : NSObject

- (id)encodeInvocations:(NSArray *)invocations;
- (NSArray *)decodeInvocations:(id)encodedInvocations;

@end
