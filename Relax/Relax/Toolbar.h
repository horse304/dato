//
//  Toolbar.h
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToolbarDelegate<NSObject>
@optional
- (void)toolbarDidChangePlaying:(BOOL)Playing;
- (void)toolbarDidChangeVolume:(float)value;
- (void)toolbarTouchedClear;
- (void)toolbarTouchedClock;
@end

@interface Toolbar : UIViewController
@property (retain) id <ToolbarDelegate> delegate;
@property (nonatomic) BOOL Playing;
@property (nonatomic) float volumeValue;
@end
