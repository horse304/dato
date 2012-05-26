//
//  GetFileURLs.m
//  Relax
//
//  Created by Dat Nguyen on 5/14/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "GetFileURLs.h"

@implementation GetFileURLs

+(NSURL *) getTestMp3{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"What Hurts The Most (Boyce Avenue acoustic cover) - Boyce Avenue" ofType:@"mp3"]];
}
@end
