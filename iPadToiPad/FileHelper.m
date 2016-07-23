//
//  FileHelper.m
//  iPadToiPad
//
//  Created by gold on 8/7/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper
@synthesize fileManager;

static FileHelper *shareFileHelperInstance = nil;
+ (FileHelper *)shareFileHelper{
    
    @synchronized(self){
        if (shareFileHelperInstance == nil) {
            shareFileHelperInstance = [[FileHelper alloc]init];
            
        }
    }
    return shareFileHelperInstance;
}

- (NSFileManager *)fileManager{
    if (fileManager == nil) {
        fileManager = [[NSFileManager alloc]init];
    }
    return fileManager;
}

+ (NSString *)getFullFilePath:(NSString *)filePath{
    return [[FileHelper getDocumentsPath]stringByAppendingPathComponent:filePath];
}

//check if file is existed
+ (BOOL)fileIsExistWithPath:(NSString *)filePath{
    return [[FileHelper shareFileHelper].fileManager fileExistsAtPath:filePath];
}
//create file
+ (BOOL)createFileWithPath:(NSString *)filePath{
    return [[FileHelper shareFileHelper].fileManager createFileAtPath:filePath contents:nil attributes:nil];
}
//delete file
+ (BOOL)deleteFileWithPath:(NSString *)filePath{
    return [[FileHelper shareFileHelper].fileManager removeItemAtPath:filePath error:NULL];
}

//check if directory is existed
+ (BOOL)dirIsExistWithPath:(NSString *)dirPath{
    BOOL isDir = YES;
    return [[FileHelper shareFileHelper].fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
}
//create directory
+ (BOOL)createDirWithPath:(NSString *)dirPath{
    return [[FileHelper shareFileHelper].fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}
//delete directory
+ (BOOL)deleteDirWithPath:(NSString *)dirPath{
    return [[FileHelper shareFileHelper].fileManager removeItemAtPath:dirPath error:NULL];
}

+ (NSString *)getDocumentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return (NSString *)[paths objectAtIndex:0];
}

+ (NSString *)getLibraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return (NSString *)[paths objectAtIndex:0];
}

+ (NSString *)getTempPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

+ (unsigned long long)getFileSizeWithPath:(NSString *)filePath{
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    return (unsigned long long)[[attributes objectForKey:NSFileSize] unsignedLongLongValue];
}

+(unsigned long long)getFileSystemFreeSize{
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSTemporaryDirectory() error:nil];
    return (unsigned long long)[[attributes objectForKey:NSFileSystemFreeSize] unsignedLongLongValue];
}

+(void)moveFile:(NSString*)file ToNewFile:(NSString*)newFile
{
    [[FileHelper shareFileHelper].fileManager moveItemAtPath:file toPath:newFile error:nil];
}

+(void)copyFile:(NSString*)file ToNewFile:(NSString*)newFile
{
    [[FileHelper shareFileHelper].fileManager copyItemAtPath:file toPath:newFile error:nil];
}

@end
