//
//  objSoundItem.m
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "objSoundItem.h"

@implementation objSoundItem

@synthesize name = _name;
@synthesize defaultImage = _defaultImage;
@synthesize selectedImage = _selectedImage;
@synthesize soundFile = _soundFile;

-(id)initWithName:(NSString *)name 
         DefaultImg:(NSString *)imageName 
        SelectedImg:(NSString *)selImgName 
          SoundFile:(NSString *)fileName{
    if (self = [super init]) {
        self.name = name;
        self.defaultImage = [UIImage imageNamed:imageName];
        self.selectedImage = [UIImage imageNamed:selImgName];
        self.soundFile = [NSURL fileURLWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName]];
    }
    return self;
}
@end
