//
//  JGFileReader.m
//  JGFileReader
//
//  Created by Julien Grimault on 8/5/12.
//  Copyright (c) 2012 julien.grimault@me.com. All rights reserved.
//

#import "JGFileReader.h"
#import "NSData+JGFileReaderAdditions.h"

@interface JGFileReader ()
@property (nonatomic, copy) NSString* filePath;
@property (nonatomic, strong) NSFileHandle* fileHandle;

@property (nonatomic) unsigned long long currentOffset;
@property (nonatomic) long long totalFileLength;
@end

@implementation JGFileReader
#pragma mark - Properties
@synthesize fileHandle = _fileHandle;
@synthesize filePath = _filePath;
@synthesize currentOffset = _currentOffset;
@synthesize totalFileLength = _totalFileLength;
@synthesize lineDelimiter = _lineDelimiter;
@synthesize chunkSize = _chunkSize;

- (id) initWithFilePath:(NSString *)aPath {
  if (self = [super init]) {
    _fileHandle = [NSFileHandle fileHandleForReadingAtPath:aPath];
    if (_fileHandle == nil) {
    	return nil;
    }
    
    _lineDelimiter = [[NSString alloc] initWithString:@"\n"];
    _filePath = [aPath copy];
    _currentOffset = 0ULL;
    _chunkSize = 10;
    [_fileHandle seekToEndOfFile];
    _totalFileLength = [_fileHandle offsetInFile];
    //we don't need to seek back, since readLine will do that.
  }
  return self;
}

- (void) dealloc {
  [self.fileHandle closeFile];
}

- (NSString *) readLine {
  if (self.currentOffset >= self.totalFileLength) { return nil; }
  
  NSData * newLineData = [self.lineDelimiter dataUsingEncoding:NSUTF8StringEncoding];
  [self.fileHandle seekToFileOffset:self.currentOffset];
  NSMutableData * currentData = [[NSMutableData alloc] init];
  BOOL shouldReadMore = YES;
  
  @autoreleasepool {
    while (shouldReadMore) {
      if (self.currentOffset >= self.totalFileLength) break;
      
      NSData * chunk = [self.fileHandle readDataOfLength:self.chunkSize];
      NSRange newLineRange = [chunk rangeOfData_dd:newLineData];
      if (newLineRange.location != NSNotFound) {
      
        //include the length so we can include the delimiter in the string
        chunk = [chunk subdataWithRange:NSMakeRange(0, newLineRange.location+[newLineData length])];
        shouldReadMore = NO;
    	}
      [currentData appendData:chunk];
      self.currentOffset += [chunk length];
  	}
  }
  
  NSString * line = [[NSString alloc] initWithData:currentData encoding:NSUTF8StringEncoding];
  return line;
}

- (NSString *) readTrimmedLine {
  return [[self readLine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL*))block {
  NSString * line = nil;
  BOOL stop = NO;
  while (stop == NO && (line = [self readLine])) {
    block(line, &stop);
  }
}
#endif
@end
