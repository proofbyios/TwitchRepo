//
//  AOServerManager.h
//  Twitch
//
//  Created by student04 on 1/21/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOServerManager : NSObject

+ (AOServerManager*) sharedManager;

- (void) getTopGamesFromServeWithLink:(NSString*) url success:(void(^)(NSDictionary* topGames)) success onFailure:(void(^)(NSError* error)) failure;

- (void) getChanelsFromServerWithNameOfGame:(NSString*) nameOfGame
                                 andNextUrl:(NSString*) nextUrl
                                  onSuccess:(void(^)(NSDictionary* chanels)) chanels
                                  onFailure:(void(^)(NSError* error)) error;

@end
