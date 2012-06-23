//
//  CXMLElement+Extention.m
//  YiLiao
//
//  Created by jtang on 12-6-13.
//  Copyright (c) 2012年 jtang. All rights reserved.
//

#import "CXMLElement+Extention.h"
#import "CXMLNode_PrivateExtensions.h"

@implementation CXMLElement (Extention)


- (NSArray *)childElements
{
  NSAssert(_node != NULL, @"CXMLNode does not have attached libxml2 _node.");
  
  NSMutableArray *theChildren = [NSMutableArray array];
  
  if (_node->type != CXMLAttributeKind) // NSXML Attribs don't have children.
  {
    xmlNodePtr theCurrentNode = _node->children;
    while (theCurrentNode != NULL)
    {
      CXMLNode *theNode = [CXMLNode nodeWithLibXMLNode:theCurrentNode freeOnDealloc:NO];
      if ([theNode isKindOfClass:[CXMLElement class]])
      {
        [theChildren addObject:theNode];
      }
      theCurrentNode = theCurrentNode->next;
    }
  }
  return(theChildren);
}

- (CXMLElement *)childAtIndex:(NSUInteger)index
{
  NSAssert(_node != NULL, @"CXMLNode does not have attached libxml2 _node.");
  
  xmlNodePtr theCurrentNode = _node->children;
  NSUInteger N;
  for (N = 0; theCurrentNode != NULL && N != index; ++N, theCurrentNode = theCurrentNode->next)
    ;
  if (theCurrentNode)
    return (CXMLElement *)([CXMLNode nodeWithLibXMLNode:theCurrentNode freeOnDealloc:NO]);
  return(NULL);
}

- (CXMLElement *)firstChild
{
  NSAssert(_node != NULL, @"CXMLNode does not have attached libxml2 _node.");
  
  NSMutableArray *theChildren = [NSMutableArray array];
  
  if (_node->type != CXMLAttributeKind) // NSXML Attribs don't have children.
  {
    xmlNodePtr theCurrentNode = _node->children;
    while (theCurrentNode != NULL && [theChildren count] == 0)
    {
      CXMLNode *theNode = [CXMLNode nodeWithLibXMLNode:theCurrentNode freeOnDealloc:NO];
      if ([theNode isKindOfClass:[CXMLElement class]])
      {
        [theChildren addObject:theNode];
      }
      theCurrentNode = theCurrentNode->next;
    }
  }
  if ([theChildren count] != 0)
    return [theChildren objectAtIndex:0];
  else
    return NULL;
}

- (NSString *)tagName
{
  return [super name];
}

- (BOOL)tagNameEquals:(NSString *)anotherTagName
{
  return [[self tagName] isEqualToString:anotherTagName];
}

- (NSString *)contentsText
{
  return [super stringValue];
}

- (NSString *)attribute:(NSString *)name
{
  // TODO -- look for native libxml2 function for finding a named attribute (like xmlGetProp)
  
  NSRange split = [name rangeOfString:@":"];
  
  xmlChar *theLocalName = NULL;
  xmlChar *thePrefix = NULL;
  
  if (split.length > 0)
  {
    theLocalName = (xmlChar *)[[name substringFromIndex:split.location + 1] UTF8String];
    thePrefix = (xmlChar *)[[name substringToIndex:split.location] UTF8String];
  }
  else
  {
    theLocalName = (xmlChar *)[name UTF8String];
  }
  
  xmlAttrPtr theCurrentNode = _node->properties;
  while (theCurrentNode != NULL)
  {
    if (xmlStrcmp(theLocalName, theCurrentNode->name) == 0)
    {
      if (thePrefix == NULL || (theCurrentNode->ns
                                && theCurrentNode->ns->prefix
                                && xmlStrcmp(thePrefix, theCurrentNode->ns->prefix) == 0))
      {
        CXMLNode *theAttribute = [CXMLNode nodeWithLibXMLNode:(xmlNodePtr)theCurrentNode freeOnDealloc:NO];
        return([theAttribute stringValue]);
      }
    }
    theCurrentNode = theCurrentNode->next;
  }
  return(NULL);
}

@end
