JGFileReader
============

A convenience class allowing reading a file line by line

Usage
-----
		JGFileReader fileReader = [[JGFileReader alloc] initWithFilePath:myFilePath];
		[fileReader enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
			NSLog(@"read line: %@", line);
		}];
		