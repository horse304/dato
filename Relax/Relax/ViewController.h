//
//  ViewController.h
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Toolbar.h"
#import "ModelController.h"
#import "MainContent.h"

@interface ViewController : UIViewController<ToolbarDelegate,MainContentDelegate>
@property (strong, nonatomic) ModelController *modelController;
-(void)applicationWillResignActive;
-(void)applicationDidBecomeActive;
@end
