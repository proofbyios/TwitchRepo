//
//  ChanelTableViewCell.h
//  Twitch
//
//  Created by student04 on 1/24/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chanelImageView;
@property (weak, nonatomic) IBOutlet UILabel *chanelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanelFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanelLanguagreLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanelStatusLabel;

@end
