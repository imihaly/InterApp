//
//  NSString+URLEncoding.h
//  IALib
//
//  Created by Imre Mihaly on 9/7/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
