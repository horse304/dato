//
//  GetImages.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "GetImages.h"

@implementation GetImages

+(NSArray *)getBackgroundLandscapes{
    NSArray *result = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"BackgroundLandscape01.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape02.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape03.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape04.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape05.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape06.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape07.jpg"],
                       [UIImage imageNamed:@"BackgroundLandscape08.jpg"],
                       nil];
    return result;
}

+(NSArray *)getBackgroundPortraits{
    NSArray *result = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"BackgroundPortrait01.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait02.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait03.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait04.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait05.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait06.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait07.jpg"],
                       [UIImage imageNamed:@"BackgroundPortrait08.jpg"],
                       nil];
    return result;
}
+(NSArray *)getCloudImages{
    NSArray *result = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"SingleCloud01.png"],
                       [UIImage imageNamed:@"SingleCloud02.png"],
                       [UIImage imageNamed:@"SingleCloud03.png"],
                       [UIImage imageNamed:@"SingleCloud04.png"],
                       [UIImage imageNamed:@"SingleCloud05.png"],
                       nil];
    
    return result;
}

+(UIImage *)getToolbarBGLandscape{
    return [UIImage imageNamed:@"CloudLandscape.png"];
}
+(UIImage *)getToolbarBGPortrait{
    return [UIImage imageNamed:@"Cloud.png"];
}

@end
