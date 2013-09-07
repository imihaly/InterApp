//
//  IASchemeManager.h
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `IAServiceManager` is the bridge class providing acces to the InterApp services.
 
 ## Dispatching Requests
 Provides access to the remote and local services torough the `proxyToService`.
 When the proxy initiates a service request the `IAServiceManager` first checks if it can be served using a localy registered service, and if no one is found then the request will be converted into a NSURL and handled using the iOS's URLSchema system.
 
 ## Rceeiving Remote Requests
 Receives and serves remote requests by `handleURL`, so this function must be called from AppDelegate's `application:openURL:sourceApplication:`.
 
 ## Registering Services
 Using `registerService:forSelector:` and `removeServiceForSelector:` the user can manipulate the set of the app's own services. Any of these services is remotely invokable if the matching scheme is registered in app's info.plist.

 */
@interface IAServiceManager : NSObject

+ (instancetype)sharedManager;

- (id)proxyToService:(NSString *)serviceSelector;
- (BOOL)handleUrl:(NSURL *)url;

- (void)registerService:(id)service forSelector:(NSString *)selector;
- (void)removeServiceForSelector:(NSString *)selector;

@end

