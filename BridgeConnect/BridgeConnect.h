//
//  BridgeConnect.h
//  Bridge
//
//  Created by Jonas Gessner on 13.01.14.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBridgeConnectVersion @"1.0"

@interface BridgeConnect : NSObject

/**
 @return If Bridge is installed and ready to import media.
 
 @discussion This method should be used to check if media import can be done, otherwise redirect the user to the download page of Bridge in Cydia: cydia://package/org.thebigboss.bridge
 */
+ (BOOL)canImportFiles;

/**
 @param paths An array containing the local paths of the files to import.
 
 Import multiple files at once. These will be recognized as an audio only album. The user can however not specify an album title.
 
 Bridge recognizes id3 tags. If unavailable it tries to extract info from the name of the files. File names should have the structure: Artist-Title-Album.extension, extension being mp3, m4a etc.
 
  @return If Bridge was successfully opened, displaying all the import options.
 */
+ (BOOL)importFilesAtPaths:(NSArray *)paths;

/**
 @param path The local path of the file to import.
 
 Import a single file at once. The user will be able to specify the type of import (music, ringtone, podcast, video etc.).
 
  Bridge recognizes id3 tags. If unavailable it tries to extract info from the name of the file. File names should have the structure: Artist-Title-Album.extension, extension being mp3, m4a etc.
 
 @return If Bridge was successfully opened, displaying all the import options.
 */
+ (BOOL)importFileAtPath:(NSString *)path;



/**
 @param paths An array containing the local paths of the files to import.
 @param titles An array containing the titles for the files, in the same order as the paths. The length of the array must be equal to the length of the \c paths array. (Optional)
 @param artist The artist. (Optional)
 @param titles The album title. (Optional)
 @param genre The genre. (Optional)
 @param artwork An album artwork image. (Optional)
 
 Import multiple files at once. These will be recognized as an audio only album. The user can however not specify an album title.
 
 Bridge will try to use the optional information provided to this method. Bridge also recognizes id3 tags and will try to do so for any information that is not specified. If both is unavailable it tries to extract info from the name of the files. File names should have the structure: Artist-Title-Album.extension, extension being mp3, m4a etc.
 
 @return If Bridge was successfully opened, displaying all the import options.
 */
+ (BOOL)importFilesAtPaths:(NSArray *)paths titles:(NSArray *)titles artist:(NSString *)artist album:(NSString *)album genre:(NSString *)genre artwork:(UIImage *)artwork;

/**
 @param path The local path of the file to import.
 @param title The title. (Optional)
 @param artist The artist. (Optional)
 @param titles The album title. (Optional)
 @param genre The genre. (Optional)
 @param artwork An album artwork image. (Optional)
 
 Import a single file at once. The user will be able to specify the type of import (music, ringtone, podcast, video etc.).
 
 Bridge will try to use the optional information provided to this method. Bridge also recognizes id3 tags and will try to do so for any information that is not specified. If both is unavailable it tries to extract info from the name of the file. File names should have the structure: Artist-Title-Album.extension, extension being mp3, m4a etc.
 
 @return If Bridge was successfully opened, displaying all the import options.
 */
+ (BOOL)importFileAtPath:(NSString *)path title:(NSString *)title artist:(NSString *)artist album:(NSString *)album genre:(NSString *)genre artwork:(UIImage *)artwork;

@end