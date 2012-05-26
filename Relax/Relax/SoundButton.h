//
//  SoundButton.h
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SoundButtonDelegate <NSObject>
@optional
-(void)soundButtonDidTouched:(id)sender;
@end

@interface SoundButton : UIViewController
@property (retain) id <SoundButtonDelegate> delegate;
@property (strong, nonatomic) NSString *soundName;
@property (nonatomic) BOOL selected;
@property (nonatomic) CGRect viewFrame;
@property (nonatomic) float relativeVolume; //relative with toolbar volume
@property (nonatomic) float mainVolume;
- (id)initWithName:(NSString *)name DefaultImg:(UIImage *)defaultImg SelectedImg:(UIImage *)selImg SoundFile:(NSURL *)soundURL;
- (void)play;
- (void)pause;
- (void)changeVolume:(float)value;
@end
