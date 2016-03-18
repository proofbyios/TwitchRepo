//
//  AOChanel.h
//  Twitch
//
//  Created by student04 on 1/24/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOChanel : NSObject

@property (strong, nonatomic) NSString* nextPartOfChanels;

@property (strong, nonatomic) NSString* nameOfGame; //game
@property (assign, nonatomic) NSInteger followersOfChanel; //followers
@property (strong, nonatomic) NSString* languageOfChanel; //language
@property (strong, nonatomic) NSString* nameOfChanel; //display_name
@property (strong, nonatomic) NSString* videoBannerOfChanel; //video_banner
@property (strong, nonatomic) NSString* statusOfChanel; //status

@end
