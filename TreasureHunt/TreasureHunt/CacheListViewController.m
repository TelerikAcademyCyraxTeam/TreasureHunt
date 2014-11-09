//
//  CacheListViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "CacheListViewController.h"
#import "CacheCellTableViewCell.h"
#import <Parse/Parse.h>
#import "Toast.h"
#import <UIKit/UIKit.h>
#import "Cache.h"
#import "CodeDataHelper.h"

@interface CacheListViewController ()
   @property(nonatomic, strong) CodeDataHelper* cdHelper;

@end

@implementation CacheListViewController{


}

-(void)viewWillAppear:(BOOL)animated{
  
}

- (void)viewDidLoad {
     [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cacheCell";
    
    CacheCellTableViewCell *cell = (CacheCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *leftSideButtons = [NSMutableArray new];
    
    [leftSideButtons sw_addUtilityButtonWithColor:[UIColor brownColor] icon:[UIImage imageNamed:@"treasure_map_min.png"]];
    [leftSideButtons sw_addUtilityButtonWithColor:[UIColor brownColor] icon:[UIImage imageNamed:@"treasure_chest_diskette_min.png"]];
    //leftSideButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.35f] icon:[UIImage imageNamed:@"treasure_chest_diskette_min.png"]];

    
    cell.leftUtilityButtons = leftSideButtons;
    cell.delegate = self;
    PFObject *obj = [self.caches objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.name.text = [obj objectForKey:@"name"];
    cell.town.text = [obj objectForKey:@"Town"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    cell.date.text = [formatter stringFromDate:obj.createdAt];
    
    return cell;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.caches count];
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            //google maps
        }
        case 1:{
            _cdHelper = [[CodeDataHelper alloc] init];
            [_cdHelper setupCoreData];

           NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
            NSInteger currentCacheIndex = currentIndexPath.row;
            PFObject *selectedCache = [self.caches objectAtIndex:currentCacheIndex];
            NSString *currentCacheName = [selectedCache objectForKey:@"name"];
            NSString *currentCacheTown = [selectedCache objectForKey:@"Town"];
            NSString *currentCacheDescription = [selectedCache objectForKey:@"casheDescrition"];
            NSString *currentCacheHint = [selectedCache objectForKey:@"hint"];
            NSString *currentCacheCreatedBy = [selectedCache objectForKey:@"createdBy"];
            NSString *currentCacheFoundBy = [selectedCache objectForKey:@"userFound"];
            NSNumber *currentCacheIsFound = [selectedCache objectForKey:@"isFound"];
            PFGeoPoint *currentCacheLocation = [selectedCache objectForKey:@"location"];
            NSString *currentCacheId = [selectedCache objectForKey:@"objectId"];
            // extract the other properties and add new object to localDB
            Cache *currentCache = [NSEntityDescription insertNewObjectForEntityForName:@"Cache" inManagedObjectContext:_cdHelper.context];
            currentCache.name = currentCacheName;
            currentCache.cacheDescription = currentCacheDescription;
            currentCache.hint = currentCacheHint;
            currentCache.userCreated = currentCacheCreatedBy;
            if (!currentCacheFoundBy) {
                currentCache.userFoundIt = currentCacheFoundBy;
            }
            currentCache.isFound = currentCacheIsFound;
            currentCache.latitude = [NSNumber numberWithDouble: currentCacheLocation.latitude];
            currentCache.longitude = [NSNumber numberWithDouble: currentCacheLocation.longitude];
            currentCache.cacheId = currentCacheId;
            
            [_cdHelper.context insertObject:currentCache];
            
            [self.cdHelper saveContext];
            
            [self.view makeToast:@"Added to favourites"];
        }
        default:
            break;
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
