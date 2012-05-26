//
//  Background.h
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Background : UIViewController

@property (strong, nonatomic) NSArray *imgLandscapes;
@property (strong, nonatomic) NSArray *imgPortraits;
@property (nonatomic) float durationAnimationImg;
@property (nonatomic) float scheduledTimer;

@end
