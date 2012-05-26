//
//  Toolbar.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "Toolbar.h"
#import "GetImages.h"

@interface Toolbar ()
@property (strong, nonatomic) IBOutlet UIImageView *viewImg;
@property (strong, nonatomic) IBOutlet UIButton *bttPlay;
@property (strong, nonatomic) IBOutlet UISlider *sliderVolume;
@property (strong, nonatomic) IBOutlet UIButton *bttClear;
@property (strong, nonatomic) IBOutlet UIButton *bttClock;

- (IBAction)doPlayPause:(id)sender;
- (IBAction)doClear:(id)sender;
- (IBAction)openClock:(id)sender;
- (IBAction)doVolumeChange:(id)sender;

@end

@implementation Toolbar
@synthesize viewImg = _viewImg;
@synthesize bttPlay = _bttPlay;
@synthesize sliderVolume = _sliderVolume;
@synthesize bttClear = _bttClear;
@synthesize bttClock = _bttClock;
@synthesize Playing = _Playing;
@synthesize volumeValue = _volumeValue;
@synthesize delegate = _delegate;
- (void)setPlaying:(BOOL)Playing{
    if (Playing) {
        _Playing = Playing;
        [self.bttPlay setBackgroundImage:[UIImage imageNamed:@"ButtonPause.png"] forState:UIControlStateNormal];
    }
    else {
        _Playing = Playing;
        [self.bttPlay setBackgroundImage:[UIImage imageNamed:@"ButtonPlay.png"] forState:UIControlStateNormal];
    }
}
- (void)setVolumeValue:(float)volumeValue{
    if (volumeValue>=0 && volumeValue<=1) {
        _volumeValue = volumeValue;
        [self.sliderVolume setValue:volumeValue];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.volumeValue = 0.8;
    [self doVolumeChange:self.sliderVolume];
    self.viewImg.image = [GetImages getToolbarBGPortrait];
}

- (void)viewDidUnload
{
    [self setViewImg:nil];
    [self setBttPlay:nil];
    [self setBttClear:nil];
    [self setBttClock:nil];
    [self setSliderVolume:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
        self.viewImg.image = [GetImages getToolbarBGPortrait];
    }else {
        self.viewImg.image = [GetImages getToolbarBGLandscape];
    }
}

- (IBAction)doPlayPause:(id)sender {
    if (self.Playing) {
        self.Playing = NO;
        if ([self.delegate respondsToSelector:@selector(toolbarDidChangePlaying:)]) {            
            [self.delegate toolbarDidChangePlaying:NO];
        }
    }else {
        self.Playing = YES;
        if ([self.delegate respondsToSelector:@selector(toolbarDidChangePlaying:)]) {            
            [self.delegate toolbarDidChangePlaying:YES];
        }
    }
}

- (IBAction)doClear:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toolbarTouchedClear)]) { 
        [self.delegate toolbarTouchedClear];
    }
}

- (IBAction)openClock:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toolbarTouchedClock)]) { 
        [self.delegate toolbarTouchedClock];
    }
}

- (IBAction)doVolumeChange:(id)sender {
    self.volumeValue = self.sliderVolume.value;
    if ([self.delegate respondsToSelector:@selector(toolbarDidChangeVolume:)]) {        
        [self.delegate toolbarDidChangeVolume:self.sliderVolume.value];
    }
}
@end
