//
//  GetImages.h
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetImages : NSObject

+(NSArray *)getBackgroundLandscapes;
+(NSArray *)getBackgroundPortraits;
+(NSArray *)getCloudImages;
+(UIImage *)getToolbarBGLandscape;
+(UIImage *)getToolbarBGPortrait;
@end
