//
//  IAPlayer.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A general-use invocation player. The passed invocations are handled as a sequence, each invocation's return value is used as target for the next invocation. The last invocation's return value is the output of the sequence.
 Supposes that the selectors has only object-type arguments and return value.
 */
@interface IAPlayer : NSObject

- (id)initWithTarget:(id)target;
- (id)playInvocations:(NSArray *)invocations;

@end
