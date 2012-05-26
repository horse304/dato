//
//  GrowingStart.h
//  Relax
//
//  Created by Dat Nguyen on 5/14/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrowingStar : UIViewController

@property (nonatomic) CGPoint centerPoint;
- (id)initWithCenterPoint:(CGPoint)point;
- (void)startAnimation;
- (void)pauseAnimation;
@end
