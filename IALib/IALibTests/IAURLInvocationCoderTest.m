//
//  IAURLInvocationCoderTest.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "IAURLInvocationCoderTest.h"
#import "IAURLInvocationCoder.h"
#import "NSInvocation+IAHelper.h"
#import "OCMock.h"

@protocol TestProtocol <NSObject>

- (id)doSomething;
- (id)doSomethingWith:(id)param;
- (id)doSomethingWith:(id)param and:(id)other;

@end

@interface IAURLInvocationCoderTest()
@property(nonatomic, strong) IAURLInvocationCoder *coder;
@end

@implementation IAURLInvocationCoderTest

- (void)testSimpleCall {
	NSArray *invocations = @[
		[NSInvocation invocationWithSelector:@selector(doSomething)]
	];
	NSString *encoded = [self.coder encodeInvocations:invocations];
	NSString *expected = [self encodedJSON:@"seq=[[\"doSomething\"]]"];
	STAssertEqualObjects(encoded, expected, @"Invalid url!");
}

- (void)testSimpleCallWithParam {
	NSArray *invocations = @[
		[NSInvocation invocationWithSelector:@selector(doSomethingWith:) andArguments:@"something", nil]
	];
	NSString *encoded = [self.coder encodeInvocations:invocations];
	NSString *expected = [self encodedJSON:@"seq=[[\"doSomethingWith:\",\"something\"]]"];
	STAssertEqualObjects(encoded, expected, @"Invalid url!");
}

- (void)testMultipleCallsWithParams {
	NSArray *invocations = @[
		[NSInvocation invocationWithSelector:@selector(doSomethingWith:) andArguments:@"something", nil],
		[NSInvocation invocationWithSelector:@selector(doSomethingWith:and:) andArguments:@"something", @"other", nil],
	];
	NSString *encoded = [self.coder encodeInvocations:invocations];
	NSString *expected = [self encodedJSON:@"seq=[[\"doSomethingWith:\",\"something\"],[\"doSomethingWith:and:\",\"something\",\"other\"]]"];
	STAssertEqualObjects(encoded, expected, @"Invalid url!");
}

- (void)setUp {
	self.coder = [[IAURLInvocationCoder alloc] init];
}

- (NSString *)encodedJSON:(NSString *)JSON {
	return [JSON stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
