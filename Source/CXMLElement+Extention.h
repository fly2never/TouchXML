//
//  CXMLElement+Extention.h
//  YiLiao
//
//  Created by jtang on 12-6-13.
//  Copyright (c) 2012年 jtang. All rights reserved.
//

#import "CXMLElement.h"

@interface CXMLElement (Extention)


- (NSArray *)childElements;

- (CXMLElement *)childAtIndex:(NSUInteger)index;

- (CXMLElement *)firstChild;

- (NSString *)tagName;

- (BOOL)tagNameEquals:(NSString *)anotherTagName;

- (NSString *)contentsText;

- (NSString *)attribute:(NSString *)name;

@end
