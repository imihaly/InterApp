//
//  IASchemeManager.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAServiceManager.h"
#import "IAServiceProxy.h"
#import "IAURLInvocationCoder.h"
#import "IAPlayer.h"

@interface IAServiceManager ()<IAInvocationHandler>
@property(nonatomic, strong) NSMutableDictionary *services;
@end

@implementation IAServiceManager

+ (instancetype)sharedManager {
	static IAServiceManager *sharedManager = nil;
	if(!sharedManager) {
		sharedManager = [IAServiceManager new];
	}
	return sharedManager;
}


- (id)init {
	self = [super init];
	if(self) {
		self.services = [NSMutableDictionary dictionary];
	}
	return self;
}

- (id)proxyToService:(NSString *)serviceSelector {
	IAServiceProxy *recorder = [[IAServiceProxy alloc] init];
	recorder.serviceSelector = serviceSelector;
	recorder.handler = self;
	return recorder;
}

- (void)registerService:(id)service forSelector:(NSString *)selector {
	self.services[selector] = service;
}

- (void)removeServiceForSelector:(NSString *)selector {
	[self.services removeObjectForKey:selector];
}

- (BOOL)handleUrl:(NSURL *)url {
	NSString *urlString = [url absoluteString];
	
	// separate service selector from request
	NSArray *components = [urlString componentsSeparatedByString:@"?"];
	if(components.count != 2) {
		return FALSE;
	}
	NSString *serviceSelector = components[0];
	NSString *request = components[1];

	NSArray *invocations = nil;
	@try {
		IAURLInvocationCoder *coder = [IAURLInvocationCoder new];
		invocations = [coder decodeInvocations:request];
	} @catch (NSException *exception) {
		NSLog(@"error when handling url: %@", url);
		return NO;
	}
	
	return [self handleRequest:invocations serviceSelector:serviceSelector];
}

- (BOOL)handleRequest:(NSArray *)invocations serviceSelector:(NSString *)serviceSelector {
	id service = [self serviceMatchingSelector:serviceSelector];
	if(!service) return NO;

	@try {
		IAPlayer *player = [[IAPlayer alloc] initWithTarget:service];
		[player playInvocations:invocations];
	}
	@catch (NSException *exception) {
		NSLog(@"error handling request: %@", invocations);
		return NO;
	}
	return YES;
}

- (id)serviceMatchingSelector:(NSString *)serviceSelector {
	return self.services[serviceSelector];
}

#pragma mark - IAInvocationHandler

- (void)invoke:(IAServiceProxy *)recorder {
	if([self handleRequest:recorder.invocations serviceSelector:recorder.serviceSelector]) return;
	
	IAURLInvocationCoder *coder = [IAURLInvocationCoder new];
	NSString *encodedInvocations = [coder encodeInvocations:recorder.invocations];
	if(!encodedInvocations) {
		NSLog(@"Could not encode the invocations!");
		return;
	};
	NSString *urlString = [NSString stringWithFormat:@"%@?%@", recorder.serviceSelector, encodedInvocations];
	NSURL *url = [NSURL URLWithString:urlString];
	[[UIApplication sharedApplication] openURL:url];
}

@end
