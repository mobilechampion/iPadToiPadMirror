//
//  FileHelper.h
//  iPadToiPad
//
//  Created by gold on 8/7/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject{
    NSFileManager *fileManager;
}
@property (nonatomic, readonly) NSFileManager *fileManager;

+ (FileHelper *)shareFileHelper;

+ (NSString *)getFullFilePath:(NSString *)filePath;

+ (BOOL)fileIsExistWithPath:(NSString *)filePath;
+ (BOOL)createFileWithPath:(NSString *)filePath;
+ (BOOL)deleteFileWithPath:(NSString *)filePath;

+ (BOOL)dirIsExistWithPath:(NSString *)dirPath;
+ (BOOL)createDirWithPath:(NSString *)dirPath;
+ (BOOL)deleteDirWithPath:(NSString *)dirPath;

+ (NSString *)getDocumentsPath;

+ (NSString *)getLibraryPath;

+ (NSString *)getTempPath;

+ (unsigned long long)getFileSizeWithPath:(NSString *)filePath;

+ (unsigned long long)getFileSystemFreeSize;

+ (void)moveFile:(NSString *)file ToNewFile:(NSString *)newFile;
+ (void)copyFile:(NSString *)file ToNewFile:(NSString *)newFile;

@end
