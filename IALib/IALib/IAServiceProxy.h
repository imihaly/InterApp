//
//  IAServiceProxy.h
//  IALib
//
//  Created by Imre Mihaly on 9/7/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "IARecorder.h"

@protocol IAInvocationHandler;

@interface IAServiceProxy : IARecorder

@property(nonatomic, copy) NSString *serviceSelector;
@property(nonatomic, assign) id<IAInvocationHandler> handler;

- (void)invoke;

@end

@protocol IAInvocationHandler <NSObject>
- (void)invoke:(IAServiceProxy *)recorder;
@end
