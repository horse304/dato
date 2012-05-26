//
//  Cloud.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Cloud.h"

@interface Cloud ()
@property (strong, nonatomic) IBOutlet UIImageView *viewImg;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSTimer *timerAnimation;
@property (nonatomic) BOOL firstRun;

@end

@implementation Cloud
@synthesize viewImg=_viewImg;
@synthesize image = _image;
@synthesize cloudFrame = _cloudFrame;
@synthesize timerAnimation = _timerAnimation;
@synthesize firstRun=_firstRun;
@synthesize randomOrder = _randomOrder;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (id)initWithCloudImage:(UIImage *)img frame:(CGRect)cloudFrame order:(int) randomOrder{
    self = [super initWithNibName:@"Cloud" bundle:nil];
    if (self) {
        _image = img;
        _cloudFrame = cloudFrame;
        _randomOrder = randomOrder;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.cloudFrame;
    self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.firstRun = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(startAnimation) userInfo:nil repeats:NO];
    //[NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)startAnimation{
    self.viewImg.image = self.image;
    if (self.firstRun) {
        int x,y;
        x = 0 - (int)(self.viewImg.image.size.width/2);
        y = (int)floor(self.view.bounds.size.height/2);
        
        self.viewImg.frame = CGRectMake(x,y, self.viewImg.image.size.width, self.viewImg.image.size.height);
        [UIView setAnimationsEnabled:YES];
        [UIView animateWithDuration:0.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{
                             self.viewImg.center = CGPointMake(x, y);
                         } 
                         completion:^(BOOL finished){        
                             if (finished){
                                 [UIView setAnimationsEnabled:YES];
                                 float duration = (self.view.bounds.size.width+self.viewImg.image.size.width/2 - self.viewImg.center.x);
                                 float delay = self.randomOrder*4;
                                 [UIView animateWithDuration:duration*0.03
                                                       delay:delay
                                                     options:UIViewAnimationOptionBeginFromCurrentState 
                                                  animations:^{                         
                                                      self.viewImg.center = CGPointMake(self.view.bounds.size.width+self.viewImg.image.size.width/2, (self.view.bounds.size.height/2));
                                                  } 
                                                  completion:^(BOOL finished){ 
                                                      if (finished) {
                                                          [UIView setAnimationsEnabled:YES];
                                                          [UIView animateWithDuration:0.0
                                                                                delay:0.0
                                                                              options:UIViewAnimationOptionBeginFromCurrentState 
                                                                           animations:^{
                                                                               self.viewImg.center = CGPointMake(0-self.viewImg.image.size.width/2, (self.view.bounds.size.height/2));
                                                                           } 
                                                                           completion:^(BOOL finished){ 
                                                                               if (finished) {                                                                               
                                                                                   self.firstRun = NO;
                                                                                   [self startAnimation];
                                                                               }
                                                                           }];
                                                      }
                                                  }];
                             }
                         }];
    }else {        
        [UIView setAnimationsEnabled:YES];
        float duration = (self.view.bounds.size.width+self.viewImg.image.size.width);
        [UIView animateWithDuration:duration*0.03
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{                         
                             self.viewImg.center = CGPointMake(self.view.bounds.size.width+self.viewImg.image.size.width/2, (self.view.bounds.size.height/2));
                         } 
                         completion:^(BOOL finished){ 
                             if (finished) {
                                 [UIView setAnimationsEnabled:YES];
                                 [UIView animateWithDuration:0.0
                                                       delay:0.0
                                                     options:UIViewAnimationOptionBeginFromCurrentState 
                                                  animations:^{
                                                      self.viewImg.center = CGPointMake(0-self.viewImg.image.size.width/2, (self.view.bounds.size.height/2));
                                                  } 
                                                  completion:^(BOOL finished){ 
                                                      if (finished){
                                                          self.firstRun = NO;
                                                          [self startAnimation];
                                                      }
                                                  }];
                             }
                         }];
    }
}

- (void)pauseAnimation{
    [self.viewImg.layer removeAllAnimations];
    self.firstRun = YES;
}

- (void)viewDidUnload
{
    [self setViewImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
