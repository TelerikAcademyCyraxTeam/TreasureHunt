//
//  CacheListViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "CacheListViewController.h"
#import "CacheCellTableViewCell.h"
#import "Toast.h"
#import <UIKit/UIKit.h>
#import "Cache.h"
#import "CodeDataHelper.h"
#import "SingleCacheMapViewController.h"

@interface CacheListViewController ()

@property(nonatomic, strong) CodeDataHelper* cdHelper;

@end

static PFObject * selectedCache;

@implementation CacheListViewController{
    UILongPressGestureRecognizer *longPress;
    UIStoryboard *storyboard;

}

+ (PFObject *) getSelectedCache{
    return selectedCache;
}

- (void)viewDidLoad {
     [super viewDidLoad];
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(loadNextView)];
    longPress.minimumPressDuration = 1.0f;
    longPress.allowableMovement = 100.0f;
    [self.view addGestureRecognizer:longPress];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadNextView{
    UIViewController *next = [storyboard instantiateViewControllerWithIdentifier:@"longPressHome"];
    [self presentViewController:next animated:YES completion:nil];
    
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
    
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
    NSInteger currentCacheIndex = currentIndexPath.row;
    selectedCache = [self.caches objectAtIndex:currentCacheIndex];
    switch (index) {
        case 0:{
            //google maps
            //load map
            SingleCacheMapViewController *viewController = [[SingleCacheMapViewController alloc] init];
            [self presentViewController:viewController animated:YES completion:nil];
            //MapViewController *mapView = [_storyboard instantiateViewControllerWithIdentifier:@"map"];
            //[self presentViewController:mapView animated:YES completion:nil];
            break;
        }
        case 1:{
            NSString *currentCacheName = [selectedCache objectForKey:@"name"];
            //NSString *currentCacheTown = [selectedCache objectForKey:@"Town"];
            NSString *currentCacheDescription = [selectedCache objectForKey:@"casheDescrition"];
            NSString *currentCacheHint = [selectedCache objectForKey:@"hint"];
            NSString *currentCacheCreatedBy = [selectedCache objectForKey:@"createdBy"];
            NSString *currentCacheFoundBy = [selectedCache objectForKey:@"userFound"];
            NSNumber *currentCacheIsFound = [selectedCache objectForKey:@"isFound"];
            PFGeoPoint *currentCacheLocation = [selectedCache objectForKey:@"location"];
            NSString *currentCacheId = selectedCache.objectId;
            
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
            //NSSortDescriptor *sort =
            //[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            //[request setSortDescriptors:[NSArray arrayWithObject:sort]];
            _cdHelper = [CodeDataHelper getInstance];
            [_cdHelper setupCoreData];
            
            NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
            
            for (Cache *cache in fetchedObjects) {
                if ([cache.cacheId isEqualToString: currentCacheId]){
                    //update existing cache
                    cache.name = currentCacheName;
                    cache.cacheDescription = currentCacheDescription;
                    cache.hint = currentCacheHint;
                    cache.userCreated = currentCacheCreatedBy;
                    if (!currentCacheFoundBy) {
                        cache.userFoundIt = currentCacheFoundBy;
                    }
                    cache.isFound = currentCacheIsFound;
                    cache.latitude = [NSNumber numberWithDouble: currentCacheLocation.latitude];
                    cache.longitude = [NSNumber numberWithDouble: currentCacheLocation.longitude];
                    
                    [self.cdHelper saveContext];
                    
                    [self.view makeToast:@"Updated in favorites"];
                    
                    return;
                }
            }
            
                //add new object to localDB
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
            break;
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
