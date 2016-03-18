//
//  AOChanelListTableViewController.m
//  Twitch
//
//  Created by student04 on 1/24/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import "AOChanelListTableViewController.h"
#import "AOGame.h"
#import "AOServerManager.h"
#import "ChanelTableViewCell.h"
#import "AOChanel.h"
#import "UIImageView+AFNetworking.h"

@interface AOChanelListTableViewController ()

@property (strong, nonatomic) NSMutableArray* chanelsArray;
@property (strong, nonatomic) NSString* nextChanels;

@end

@implementation AOChanelListTableViewController

CGFloat hieghtForRows = 80.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextChanels = @"next";
    
    self.chanelsArray = [NSMutableArray array];
    
    self.navigationItem.title = self.gameObgect.nameOfGame;
    
    [self getChanelsFromServerWithNameOfGame:self.gameObgect.nameOfGame andNextUrl:self.nextChanels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getChanelsFromServerWithNameOfGame:(NSString*) nameOfGame andNextUrl:(NSString*) nextUrl {
    
    [[AOServerManager sharedManager] getChanelsFromServerWithNameOfGame:nameOfGame andNextUrl:nextUrl onSuccess:^(NSDictionary *chanels) {
        
        self.nextChanels = [[chanels objectForKey:@"_links"] objectForKey:@"next"];
        
        NSDictionary* chanel = [chanels objectForKey:@"streams"];
        
        for (NSDictionary* dict in chanel) {
            AOChanel* chanel = [[AOChanel alloc] init];
            
            chanel.nameOfChanel = [[dict objectForKey:@"channel"] objectForKey:@"display_name"];
            chanel.languageOfChanel = [[dict objectForKey:@"channel"] objectForKey:@"language"];
            
            if ([[[dict objectForKey:@"channel"] objectForKey:@"followers"] integerValue]) {
                chanel.followersOfChanel = [[[dict objectForKey:@"channel"] objectForKey:@"followers"] integerValue];
            }
            
            chanel.videoBannerOfChanel = [[dict objectForKey:@"channel"] objectForKey:@"video_banner"];
            chanel.statusOfChanel = [[dict objectForKey:@"channel"] objectForKey:@"status"];
            
            [self.chanelsArray addObject:chanel];
        }
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chanelsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifire = @"chanelCell";
    
    ChanelTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    
    cell.chanelImageView.image = nil;
    
    AOChanel* chanelCell = [self.chanelsArray objectAtIndex:indexPath.row];
    
    if (chanelCell.nameOfChanel) {
        cell.chanelNameLabel.text = chanelCell.nameOfChanel;
    }
    if (chanelCell.languageOfChanel) {
        cell.chanelLanguagreLabel.text = chanelCell.languageOfChanel;
    }
    if (chanelCell.statusOfChanel) {
        cell.chanelStatusLabel.text = chanelCell.statusOfChanel;
    }
    if (chanelCell.followersOfChanel) {
        cell.chanelFollowersLabel.text = [NSString stringWithFormat:@"Fololowers: %ld", chanelCell.followersOfChanel];
    }
    
    if (chanelCell.videoBannerOfChanel) {
        NSURL* imageUrl = [NSURL URLWithString:chanelCell.videoBannerOfChanel];
        NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl];
        
        [cell.chanelImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            cell.chanelImageView.image = image;
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            NSLog(@"Error while downloading image: %@", [error localizedDescription]);
        }];
    }
    
    NSLog(@"Cell display: %ld", indexPath.row);
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hieghtForRows;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.chanelsArray count] - 1) {
        [self getChanelsFromServerWithNameOfGame:self.gameObgect.nameOfGame andNextUrl:self.nextChanels];
    }
    
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
