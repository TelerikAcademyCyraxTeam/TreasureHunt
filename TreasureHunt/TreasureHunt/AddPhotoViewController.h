//
//  AddPhotoViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/9/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;

@end
