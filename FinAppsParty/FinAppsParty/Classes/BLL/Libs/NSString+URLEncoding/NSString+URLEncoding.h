//
//  NSString+URLEncoding.h
//  la_iaia
//
//  Created by Valentí on 04/02/12.
//  Copyright (c) 2012 Biapum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end