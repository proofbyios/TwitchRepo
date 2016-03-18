//
//  AOChanelListTableViewController.h
//  Twitch
//
//  Created by student04 on 1/24/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOServerManager.h"

@class AOGame;

@interface AOChanelListTableViewController : UIViewController

@property (strong, nonatomic) AOGame* gameObgect;
@property (strong, nonatomic) IBOutlet UITableView* tableView;



@end
