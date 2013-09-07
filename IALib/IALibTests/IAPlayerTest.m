//
//  IAPlayerTest.m
//  InterApp
//
//  Created by Imre Mihaly on 9/5/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "IAPlayerTest.h"
#import "IARecorder.h"
#import "IAPlayer.h"
#import "OCMock.h"

@protocol TestProtocol <NSObject>

- (id)doSomething;
- (id)doSomethingWith:(id)param;
- (id)doSomethingWith:(id)param and:(id)other;

@end

@implementation IAPlayerTest

- (void)testSimpleInvocation {
	id target = [OCMockObject mockForProtocol:@protocol(TestProtocol)];
	[[[target expect] andReturn:nil] doSomething];
	
	id recorder = [[IARecorder alloc] init];
	[recorder doSomething];
	
	IAPlayer *player = [[IAPlayer alloc] initWithTarget:target];
	[player playInvocations:[recorder invocations]];
	
	[target verify];
}

- (void)testChainedInvocation {
	id target2 = [OCMockObject mockForProtocol:@protocol(TestProtocol)];
	id target1 = [OCMockObject mockForProtocol:@protocol(TestProtocol)];
	id target0 = [OCMockObject mockForProtocol:@protocol(TestProtocol)];
	
	[[[target0 expect] andReturn:target1] doSomething];
	[[[target1 expect] andReturn:target2] doSomething];
	[[[target2 expect] andReturn:nil] doSomething];
	
	id recorder = [[IARecorder alloc] init];
	
	[[[recorder doSomething] doSomething] doSomething];
	
	IAPlayer *player = [[IAPlayer alloc] initWithTarget:target0];
	[player playInvocations:[recorder invocations]];
	
	[target0 verify];
	[target1 verify];
	[target2 verify];
}

- (void)testSimpleInvocationWithParam {
	id target = [OCMockObject mockForProtocol:@protocol(TestProtocol)];
	[[[target expect] andReturn:nil] doSomethingWith:@"something"];
	
	id recorder = [[IARecorder alloc] init];
	[recorder doSomethingWith:@"something"];
	
	IAPlayer *player = [[IAPlayer alloc] initWithTarget:target];
	[player playInvocations:[recorder invocations]];
	
	[target verify];
}

@end
