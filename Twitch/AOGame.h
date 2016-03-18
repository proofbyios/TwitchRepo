//
//  AOGame.h
//  Twitch
//
//  Created by student04 on 1/23/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOGame : NSObject

@property (assign, nonatomic) NSInteger chanelsGameCount;
@property (strong, nonatomic) NSString* logoGame;
@property (strong, nonatomic) NSString* nameOfGame;
@property (assign, nonatomic) NSInteger viewersCount;

@end
