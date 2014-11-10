//
//  FavouritesViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "FavouritesViewController.h"
#import "CacheCellTableViewCell.h"
#import "Toast.h"
#import <UIKit/UIKit.h>
#import "Cache.h"
#import "CodeDataHelper.h"
#import "SingleCacheMapViewController.h"
#import "CacheDetailsViewController.h"

@interface FavouritesViewController ()
@property(nonatomic, strong) CodeDataHelper* cdHelper;
@end

@implementation FavouritesViewController{
    UILongPressGestureRecognizer *longPress;
    UIStoryboard *_storyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateTable];
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(loadNextView)];
    longPress.minimumPressDuration = 1.0f;
    longPress.allowableMovement = 100.0f;
    [self.view addGestureRecognizer:longPress];
    self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTable{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
    _cdHelper = [CodeDataHelper getInstance];
    [_cdHelper setupCoreData];
    NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
    self.caches = [fetchedObjects mutableCopy];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadNextView{
    UIViewController *next = [_storyboard instantiateViewControllerWithIdentifier:@"longPressHome"];
    [self presentViewController:next animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cacheCell";
    
    CacheCellTableViewCell *cell = (CacheCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *leftSideButtons = [NSMutableArray new];
    
    [leftSideButtons sw_addUtilityButtonWithColor:[UIColor brownColor] icon:[UIImage imageNamed:@"treasure_map_min.png"]];
    [leftSideButtons sw_addUtilityButtonWithColor:[UIColor brownColor] icon:[UIImage imageNamed:@"cross.png"]];
    
    
    cell.leftUtilityButtons = leftSideButtons;
    cell.delegate = self;
    Cache *currentCache = [self.caches objectAtIndex:indexPath.row];
    
    cell.name.text = currentCache.name;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.caches count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CacheDetailsViewController *details = [_storyboard instantiateViewControllerWithIdentifier:@"details"];
    Cache *selectedCache = [self.caches objectAtIndex:indexPath.row];
  //  details.localCache = selectedCache;
    [self presentViewController:details animated:YES completion:nil];
    
}


-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
    NSInteger currentCacheIndex = currentIndexPath.row;
    switch (index) {
        case 0:{
            SingleCacheMapViewController *mapView = [[SingleCacheMapViewController alloc] init];
            [self presentViewController:mapView animated:YES completion:nil];
            break;
        }
        case 1:{
            NSArray *paths = [NSArray arrayWithObject:currentIndexPath];
            Cache *currentCache =[self.caches objectAtIndex:currentIndexPath.row];
            [self.caches removeObjectAtIndex:currentCacheIndex];
            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
            
            //updating local database
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
            NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
            for(Cache *cache in fetchedObjects){
                if([cache.name isEqualToString:currentCache.name]){
                    [_cdHelper.context deleteObject:cache];
                    
                    [self.cdHelper saveContext];
                }
            }
            break;
        }
        default:
            break;
    }
}

@end
