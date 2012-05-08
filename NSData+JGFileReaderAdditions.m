//
//  NSData+JGFileReaderAdditions.m
//  JGFileReader
//
//  Created by Julien Grimault on 8/5/12.
//  Copyright (c) 2012 julien.grimault@me.com. All rights reserved.
//

#import "NSData+JGFileReaderAdditions.h"

@implementation NSData (JGFileReaderAdditions)

- (NSRange) rangeOfData_dd:(NSData *)dataToFind {
  
  const void * bytes = [self bytes];
  NSUInteger length = [self length];
  
  const void * searchBytes = [dataToFind bytes];
  NSUInteger searchLength = [dataToFind length];
  NSUInteger searchIndex = 0;
  
  NSRange foundRange = {NSNotFound, searchLength};
  for (NSUInteger index = 0; index < length; index++) {
    if (((char *)bytes)[index] == ((char *)searchBytes)[searchIndex]) {
      //the current character matches
      if (foundRange.location == NSNotFound) {
        foundRange.location = index;
      }
      searchIndex++;
      if (searchIndex >= searchLength) { return foundRange; }
    } else {
      searchIndex = 0;
      foundRange.location = NSNotFound;
    }
  }
  return foundRange;
}

@end
