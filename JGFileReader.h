//
//  JGFileReader.h
//  JGFileReader
//
//  Created by Julien Grimault on 8/5/12.
//  Copyright (c) 2012 julien.grimault@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFileReader : NSObject

- (id) initWithFilePath:(NSString *)aPath;
//the file we are reading from
@property (nonatomic, readonly, copy) NSString* filePath;

//the line delimiter to be used when readin the file
@property (nonatomic, copy) NSString * lineDelimiter;
//maximum size of the chunk of data read from the file at once. Default is 10
@property (nonatomic) NSUInteger chunkSize;


- (NSString *) readLine;
- (NSString *) readTrimmedLine;

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL *))block;
#endif

@end
