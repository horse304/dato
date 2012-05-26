//
//  ModelController.m
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//
#import "Config.h"
#import "ModelController.h"
#import "objSoundItem.h"

@interface ModelController()
@property (strong,readwrite,nonatomic) NSMutableArray * soundArray;
@end

@implementation ModelController
@synthesize soundArray = _soundArray;

- (id) init{
    if (self = [super init]) {
        self.soundArray = [[NSMutableArray alloc] init];
        [self loadResourcePlist];
    }
    
    return self;
}

//Loading sounds info from Resources.plist
- (void) loadResourcePlist{
    NSDictionary *resourceData = [NSDictionary dictionaryWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:RESOURCES_PLIST]];
    NSArray *itemArray = [resourceData objectForKey:@"Sounds"];
    for (NSDictionary *item in itemArray) {

        objSoundItem *newSound = [[objSoundItem alloc] initWithName:[item objectForKey:@"Name"] 
                                                         DefaultImg:[item objectForKey:@"Default Image"] 
                                                        SelectedImg:[item objectForKey:@"Selected Image"]
                                                          SoundFile:[item objectForKey:@"Sound File"]];
        if (newSound) {            
            [self.soundArray addObject:newSound];
        }
        
    }
}

@end
