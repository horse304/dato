//
//  mainContent.h
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundButton.h"
@protocol MainContentDelegate<NSObject>
@optional
-(void)mainContentDidTouchedSoundButton:(id)sender;
@end

@interface MainContent : UIViewController<UIScrollViewDelegate, SoundButtonDelegate>
@property (retain) id <MainContentDelegate> delegate;
@property (nonatomic) CGRect viewFrame;
- (id)initWithSoundArray:(NSArray *)sounds Frame:(CGRect)frame;
- (void)play;
- (void)pause;
- (void)changeVolume:(float)value;
- (void)clear;
- (void)playRandom;
@end
