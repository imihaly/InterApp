//
//  IARecorder.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
	A general-use invocation recorder.
	It recorders any selectors called on it, but supposes that the selectors has only object-type arguments and return value. The sequence of the invocations can be played back using an `IAPlayer`.
 */
@interface IARecorder : NSProxy

- (id)init;
- (NSArray *)invocations;

@end
