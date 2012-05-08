//
//  NSData+JGFileReaderAdditions.m
//  JGFileReader
//
//  Created by Julien Grimault on 8/5/12.
//  Copyright (c) 2012 Julien Grimault
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
