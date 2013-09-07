//
//  IASchemeManager.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAServiceManager : NSObject

+ (instancetype)sharedManager;

- (id)proxyToService:(NSString *)serviceSelector;
- (BOOL)handleUrl:(NSURL *)url;

- (void)registerService:(id)service forSelector:(NSString *)selector;
- (void)removeServiceForSelectro:(NSString *)selector;

@end

