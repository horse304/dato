//
//  objSoundItem.h
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objSoundItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *defaultImage;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) NSURL *soundFile;

-(id)initWithName:(NSString *)name 
       DefaultImg:(NSString *)imageName 
      SelectedImg:(NSString *)selImgName 
        SoundFile:(NSString *)fileName;

@end
