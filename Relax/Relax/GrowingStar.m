//
//  GrowingStart.m
//  Relax
//
//  Created by Dat Nguyen on 5/14/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "GrowingStar.h"

@interface GrowingStar ()
@property (nonatomic) BOOL isFirstRun;
@end

@implementation GrowingStar
@synthesize centerPoint = _centerPoint;
@synthesize isFirstRun = _isFirstRun;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCenterPoint:(CGPoint)point{
    self = [super initWithNibName:@"GrowingStar" bundle:nil];
    if (self) {
        _centerPoint = point;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 100, 100);
    self.view.center = self.centerPoint;    
    self.isFirstRun = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(startAnimation) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)startAnimation{  
    if (self.isFirstRun) {  
        [UIView animateWithDuration:0.0 
                              delay:0.0 
                            options:UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{
                             self.view.frame = CGRectMake(self.centerPoint.x-50, self.centerPoint.y-50, 100, 100);
                             self.view.alpha = 1;       
                         }         
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [UIView animateWithDuration:5.0 
                                                       delay:arc4random() % 4
                                                     options:UIViewAnimationOptionBeginFromCurrentState 
                                                  animations:^{                                              
                                                      self.view.frame = CGRectMake(self.centerPoint.x-5, self.centerPoint.y-5, 10, 10);
                                                      self.view.alpha = 0.5;
                                                  } 
                                                  completion:^(BOOL finished) {
                                                      if (finished){
                                                          [UIView animateWithDuration:5.0 
                                                                                delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState 
                                                                           animations:^{                                                                   
                                                                               self.view.frame = CGRectMake(self.centerPoint.x-50, self.centerPoint.y-50, 100, 100);
                                                                               
                                                                               self.view.alpha = 1;
                                                                           }
                                                                           completion:^(BOOL finished) {
                                                                               if (finished){
                                                                                   [self startAnimation];                                                                       
                                                                                   self.isFirstRun = NO;
                                                                               }
                                                                           }];
                                                      }
                                                  }];
                             }
                         }];
    }else {
        [UIView animateWithDuration:5.0 
                              delay:0.0 
                            options:UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{                                              
                             self.view.frame = CGRectMake(self.centerPoint.x-5, self.centerPoint.y-5, 10, 10);
                             
                             self.view.alpha = 0.5;
                         } 
                         completion:^(BOOL finished) { 
                             if (finished){
                                 [UIView animateWithDuration:5.0 
                                                       delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState 
                                                  animations:^{                                                                   
                                                      self.view.frame = CGRectMake(self.centerPoint.x-50, self.centerPoint.y-50, 100, 100);
                                                      
                                                      self.view.alpha = 1;
                                                  }
                                                  completion:^(BOOL finished) {
                                                      if (finished){
                                                          [self startAnimation];
                                                      }
                                                  }];
                             }
                         }];
    }
}

- (void)pauseAnimation{
    [self.view.layer removeAllAnimations];
    self.isFirstRun = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
