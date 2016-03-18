//
//  AOServerManager.m
//  Twitch
//
//  Created by student04 on 1/21/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import "AOServerManager.h"
#import "AFNetworking.h"

@implementation AOServerManager

+ (AOServerManager*) sharedManager {
    
    static AOServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AOServerManager alloc] init];
    });
    
    return manager;
}


- (void) getTopGamesFromServeWithLink:(NSString*) url success:(void(^)(NSDictionary* topGames)) success onFailure:(void(^)(NSError* error)) failure {
    if (!url) {
        url = @"https://api.twitch.tv/kraken/games/top";
    }
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) getChanelsFromServerWithNameOfGame:(NSString*) nameOfGame
                                 andNextUrl:(NSString*) nextUrl
                                  onSuccess:(void(^)(NSDictionary* chanels)) success
                                  onFailure:(void(^)(NSError* error)) failure {
    
    NSString* query = @"";
    
    if ([nextUrl isEqualToString:@"next"]) {
        NSString* getQuery = @"https://api.twitch.tv/kraken/streams";
        NSString* newNameString = [nameOfGame stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        query = [getQuery stringByAppendingFormat:@"?game=%@", newNameString];
    } else {
        query = nextUrl;
    }
    
    [[AFHTTPSessionManager manager] GET:query parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
