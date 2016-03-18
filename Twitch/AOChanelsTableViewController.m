//
//  AOChanelsTableViewController.m
//  Twitch
//
//  Created by student04 on 1/21/16.
//  Copyright © 2016 student04. All rights reserved.
//

#import "AOChanelsTableViewController.h"
#import "AOServerManager.h"
#import "GameTableViewCell.h"
#import "AOGame.h"
#import "UIImageView+AFNetworking.h"
#import "AOChanelListTableViewController.h"


@interface AOChanelsTableViewController ()

@property (strong, nonatomic) NSString* nextTopTenGames;
@property (assign, nonatomic) NSInteger totalGames;
@property (strong, nonatomic) NSMutableArray* gamesArray;
@property (strong, nonatomic) AOGame* currentGame;


@end

@implementation AOChanelsTableViewController

CGFloat hieghtForRow = 80.f;

- (void) loadView {
    [super loadView];
    
    self.gamesArray = [NSMutableArray array];
    
    [self getTopGamesFromServerWithLink:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (NSMutableArray*) getTopGamesFromServerWithLink:(NSString*) link {
    
    [[AOServerManager sharedManager] getTopGamesFromServeWithLink:link success:^(NSDictionary *topGames) {

        NSDictionary* links = [topGames objectForKey:@"_links"];
        self.nextTopTenGames = [links objectForKey:@"next"];
        
        self.totalGames = [[topGames objectForKey:@"_total"] integerValue];
        
        NSDictionary* gamesDictionary = [topGames objectForKey:@"top"];
        
        for (NSDictionary* oneGame in gamesDictionary) {
            AOGame* game = [[AOGame alloc] init];
            
            if ([[oneGame objectForKey:@"channels"] integerValue]) {
                game.chanelsGameCount = [[oneGame objectForKey:@"channels"] integerValue];
            }
            if ([[oneGame objectForKey:@"viewers"] integerValue]) {
                game.viewersCount = [[oneGame objectForKey:@"viewers"] integerValue];
            }
            
            NSDictionary* gameDictionary = [oneGame objectForKey:@"game"];
            
            game.logoGame = [[gameDictionary objectForKey:@"box"] objectForKey:@"large"];
            game.nameOfGame = [gameDictionary objectForKey:@"name"];
            
            [self.gamesArray addObject:game];
        }
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    
    return self.gamesArray;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gamesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* identifire = @"cell";
    
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    
    cell.gameLogoImageView.image = nil;
    
    AOGame* game = [self.gamesArray objectAtIndex:indexPath.row];
    
    cell.gameNameLabel.text = game.nameOfGame;
    cell.gameViewersLabel.text = [NSString stringWithFormat:@"Viewers: %ld", game.viewersCount];
    NSURL* imageURL = [NSURL URLWithString:game.logoGame];
    if (imageURL) {
        [cell.gameLogoImageView setImageWithURL:imageURL];
    }
    
    
    return cell;
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hieghtForRow;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentGame = [self.gamesArray objectAtIndex:indexPath.row];
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.gamesArray count] - 1) {
        [self getTopGamesFromServerWithLink:self.nextTopTenGames];
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AOChanelListTableViewController* gvc = [segue destinationViewController];
    
    [gvc setGameObgect:self.currentGame];
}




@end
