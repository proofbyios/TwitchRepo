//
//  GameTableViewCell.h
//  Twitch
//
//  Created by student04 on 1/23/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *gameLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameViewersLabel;

@end
