//
//  NSData+JGFileReaderAdditions.h
//  JGFileReader
//
//  Created by Julien Grimault on 8/5/12.
//  Copyright (c) 2012 julien.grimault@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JGFileReaderAdditions)

- (NSRange) rangeOfData_dd:(NSData *)dataToFind;

@end
