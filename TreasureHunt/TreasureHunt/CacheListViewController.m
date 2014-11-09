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

@interface CacheListViewController (){
   
}

@end

@implementation CacheListViewController{
    UILongPressGestureRecognizer *longPress;
    UIStoryboard *storyboard;

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
    switch (index) {
        case 0:{
            //google maps
        }
        case 1:{

           NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
            NSInteger currentCacheIndex = currentIndexPath.row;
            PFObject *selectedCache = [self.caches objectAtIndex:currentCacheIndex];
            NSString *currentCacheName = [selectedCache objectForKey:@"name"];
            NSString *currentCacheTown = [selectedCache objectForKey:@"Town"];
            // extract the other properties and add new object to localDB
            
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
