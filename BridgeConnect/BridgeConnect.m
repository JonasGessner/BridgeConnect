//
//  BridgeConnect.m
//  Bridge
//
//  Created by Jonas Gessner on 13.01.14.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import "BridgeConnect.h"

#if !__has_feature(objc_arc)
#error BridgeConnect needs to be compiled with ARC enabled.
#endif

#define kBridgeCurrentAPIURLScheme @"bridgeAPIvA://"

#define kBridgeMetadataFilePath [NSTemporaryDirectory() stringByAppendingPathComponent:@"BridgeImportMetadata.plist"]
#define kBridgeAlbumArtworkFilePath [NSTemporaryDirectory() stringByAppendingPathComponent:@"AlbumArt.png"]

#define kLibBridgeTitlesKey @"Titles"
#define kLibBridgeArtistKey @"Artist"
#define kLibBridgeAlbumKey @"Album"
#define kLibBridgeGenreKey @"Genre"
#define kLibBridgeArtworkPathKey @"Artwork"
#define kLibBridgeContentsKey @"Contents"

#define kLibBridgeIsMultiKey @"Multi"

@implementation BridgeConnect

+ (BOOL)canImportFiles {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kBridgeCurrentAPIURLScheme]];
}

+ (BOOL)importFileAtPath:(NSString *)path {
    return [self importFilesAtPaths:@[path]];
}

+ (BOOL)importFilesAtPaths:(NSArray *)paths {
    return [self importFilesAtPaths:paths titles:nil artist:nil album:nil genre:nil artwork:nil];
}

+ (BOOL)importFileAtPath:(NSString *)path title:(NSString *)title artist:(NSString *)artist album:(NSString *)album genre:(NSString *)genre artwork:(UIImage *)artwork {
    return [self importFilesAtPaths:@[path] titles:@[title] artist:artist album:album genre:genre artwork:artwork];
}


+ (BOOL)importFilesAtPaths:(NSArray *)paths titles:(NSArray *)titles artist:(NSString *)artist album:(NSString *)album genre:(NSString *)genre artwork:(UIImage *)artwork {
    if (!self.canImportFiles) {
        return NO;
    }
    
    if (!paths.count) {
        return NO;
    }
    
    NSMutableDictionary *final = [NSMutableDictionary dictionaryWithCapacity:2+(titles.count > 0)+(artist.length > 0)+(album.length > 0)+(genre.length > 0)+(artwork != nil)];
    
    final[kLibBridgeIsMultiKey] = @(paths.count > 1);
    final[kLibBridgeContentsKey] = (paths.count > 1 ? paths : paths.firstObject);
    
    if (titles.count) {
        final[kLibBridgeTitlesKey] = titles;
    }
    
    if (artist.length) {
        final[kLibBridgeArtistKey] = artist;
    }
    
    if (album.length) {
        final[kLibBridgeAlbumKey] = album;
    }
    
    if (genre.length) {
        final[kLibBridgeGenreKey] = genre;
    }
    
    if (artwork != nil) {
        if (![UIImagePNGRepresentation(artwork) writeToFile:kBridgeAlbumArtworkFilePath atomically:YES]) {
            return NO;
        }
        else {
            final[kLibBridgeArtworkPathKey] = kBridgeAlbumArtworkFilePath;
        }
    }
    
    if (![final writeToFile:kBridgeMetadataFilePath atomically:YES]) {
        return NO;
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBridgeCurrentAPIURLScheme, kBridgeMetadataFilePath]];
    
    [[UIApplication sharedApplication] openURL:URL];
    
    return YES;
}



@end
