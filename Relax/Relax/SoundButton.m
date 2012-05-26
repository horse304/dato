//
//  SoundButton.m
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SoundButton.h"

@interface SoundButton ()
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) UIImage *defImg;
@property (strong, nonatomic) UIImage *selImg;
@property (strong, nonatomic) NSURL *soundURL;

@property (strong, nonatomic) AVAudioPlayer *soundPlayer;
@end

@implementation SoundButton

#pragma mark - encapsulation
@synthesize delegate = _delegate;
@synthesize selected = _selected;
@synthesize button=_button;
@synthesize label=_label;
@synthesize soundName = _soundName;
@synthesize defImg = _defImg;
@synthesize selImg = _selImg;
@synthesize soundURL = _soundURL;
@synthesize soundPlayer = _soundPlayer;
@synthesize viewFrame = _viewFrame;
@synthesize relativeVolume = _relativeVolume;
@synthesize mainVolume = _mainVolume;
- (void)setSelected:(BOOL)selected{
    if (selected) {
        _selected = selected;
        [self.button setBackgroundImage:self.selImg forState:UIControlStateNormal];
        [self play];
    }else {
        _selected = selected;
        [self.button setBackgroundImage:self.defImg forState:UIControlStateNormal];        
        [self pause];
    }
}
- (void)setViewFrame:(CGRect)viewFrame{
    _viewFrame = viewFrame;
    self.view.frame = viewFrame;
    self.button.center = CGPointMake(self.view.bounds.size.width/2+9, self.view.bounds.size.height/2);
    self.label.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+30);
}
- (void)setRelativeVolume:(float)relativeVolume{
    if (relativeVolume >= 0 && relativeVolume <= 1) {
        _relativeVolume = relativeVolume;
        if (self.soundPlayer) {
            self.soundPlayer.volume = relativeVolume * self.mainVolume;
        }
    }
}

#pragma mark - construction
- (id)initWithName:(NSString *)name DefaultImg:(UIImage *)defaultImg SelectedImg:(UIImage *)selImg SoundFile:(NSURL *)soundURL
{
    self = [super initWithNibName:@"SoundButton" bundle:nil];
    if (self) {
        self.soundName = name;
        self.defImg = defaultImg;
        self.selImg = selImg;
        self.soundURL = soundURL;
        
        self.relativeVolume = 1;
        self.selected = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set label text
    [self.label setText:self.soundName];    
    //Set button image
    if (self.selected) {
        [self.button setBackgroundImage:self.selImg forState:UIControlStateNormal];
    }else {
        [self.button setBackgroundImage:self.defImg forState:UIControlStateNormal];   
    }    
    //Set player url
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.soundURL error:nil];
    self.soundPlayer.volume = 1;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops = -1;
}

- (void)viewDidUnload
{
    [self setSoundPlayer:nil];
    [self setButton:nil];
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Event Handling
- (IBAction)touchedButton:(id)sender {
    if (self.selected) {
        self.selected = NO;        
    }else {
        self.selected = YES;
        //send to delegate
        [self.delegate soundButtonDidTouched:self];
    }
}

- (void)play{
    if (self.selected) {
        if (!self.soundPlayer.playing) {
            [self.soundPlayer play];
            //Start animation
        }
    }
}

- (void)pause{
    if (self.soundPlayer.playing) {
        [self.soundPlayer pause];
        //pause animation
    }
}

- (void)changeVolume:(float)value{
    self.mainVolume = value;
    self.soundPlayer.volume = self.relativeVolume * self.mainVolume;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
