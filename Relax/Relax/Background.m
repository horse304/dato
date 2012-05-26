//
//  Background.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Background.h"

@interface Background ()
@property (strong, nonatomic) IBOutlet UIImageView *frontIMG;
@property (strong, nonatomic) IBOutlet UIImageView *backIMG;
@property (strong, nonatomic) NSTimer *timerChangeIMG;
@end

@implementation Background
@synthesize frontIMG = _frontIMG;
@synthesize backIMG = _backIMG;
@synthesize imgLandscapes = _imgLandscapes;
@synthesize imgPortraits = _imgPortraits;
@synthesize timerChangeIMG = _timerChangeIMG;
@synthesize durationAnimationImg = _durationAnimationImg;
@synthesize scheduledTimer = _scheduledTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _durationAnimationImg = 4;
        _scheduledTimer = 8;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.frontIMG.alpha = 1;
    self.backIMG.alpha = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeIMGto:) userInfo:nil repeats:NO];
    self.timerChangeIMG = [NSTimer scheduledTimerWithTimeInterval:self.scheduledTimer target:self selector:@selector(changeIMGto:) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)changeIMGto:(NSTimer *)timer{
    UIInterfaceOrientation toInerfaceOrientation;
    if (timer == nil) {
        toInerfaceOrientation = UIInterfaceOrientationPortrait;
    }else {
        toInerfaceOrientation = [[timer userInfo] intValue];
    }
    if (UIDeviceOrientationIsLandscape(toInerfaceOrientation)){        
        if (!self.frontIMG.image || [self.imgLandscapes indexOfObject:self.frontIMG.image] == NSNotFound) {
            self.frontIMG.image = [self.imgLandscapes objectAtIndex:0];
        }
        int backIndex = [self.imgLandscapes indexOfObject:self.frontIMG.image]+1;
        if (backIndex == self.imgLandscapes.count) {
            backIndex = 0;
        }
        self.backIMG.image = [self.imgLandscapes objectAtIndex:backIndex];
    }else {        
        if (!self.frontIMG.image || [self.imgPortraits indexOfObject:self.frontIMG.image] == NSNotFound) {
            self.frontIMG.image = [self.imgPortraits objectAtIndex:0];
        }
        int backIndex1 = [self.imgPortraits indexOfObject:self.frontIMG.image]+1;
        if (backIndex1 == self.imgPortraits.count) {
            backIndex1 = 0;
        }
        self.backIMG.image = [self.imgPortraits objectAtIndex:backIndex1];
    }
    
    //Animation
    [UIView setAnimationsEnabled:YES];
    [UIView animateWithDuration:self.durationAnimationImg 
                          delay:0.00 
                        options:UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{                         
                         self.frontIMG.alpha = 0;
                         self.backIMG.alpha = 1;
                     } 
                     completion:^(BOOL finished){  
                         if (finished) {      
                             UIImageView *tmp = self.frontIMG;
                             self.frontIMG = self.backIMG;
                             self.backIMG = tmp;
                         }
                     }];
}

- (void)viewDidUnload
{
    [self setFrontIMG:nil];
    [self setBackIMG:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.timerChangeIMG invalidate];
    self.timerChangeIMG = nil;
    if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
        self.frontIMG.image = [self.imgPortraits objectAtIndex:0];
    }else {
        self.frontIMG.image = [self.imgLandscapes objectAtIndex:0];
    }     
    self.frontIMG.alpha = 1;
    self.backIMG.alpha = 0;
    self.timerChangeIMG = [NSTimer scheduledTimerWithTimeInterval:self.scheduledTimer 
                                                           target:self 
                                                         selector:@selector(changeIMGto:) 
                                                         userInfo:[NSNumber numberWithInt:toInterfaceOrientation] 
                                                          repeats:YES];    
}

@end
