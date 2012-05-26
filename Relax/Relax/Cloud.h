//
//  Cloud.h
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cloud : UIViewController

@property (nonatomic) CGRect cloudFrame;
@property (nonatomic) int randomOrder;
- (id)initWithCloudImage:(UIImage *)img frame:(CGRect) cloudFrame order:(int) randomOrder;
- (void)startAnimation;
- (void)pauseAnimation;
@end
