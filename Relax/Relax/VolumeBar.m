//
//  VolumeBar.m
//  Relax
//
//  Created by Dat Nguyen on 5/18/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "VolumeBar.h"
#import "SoundButton.h"

@interface VolumeBar ()
@property (weak, nonatomic) IBOutlet UILabel *lblSoundName;
@property (weak, nonatomic) IBOutlet UISlider *sliderSoundVolume;
@property (strong, nonatomic) NSTimer *timerClose;
@property (retain, nonatomic) id SoundButton;
- (IBAction)close:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
@end

@implementation VolumeBar
@synthesize lblSoundName = _lblSoundName;
@synthesize sliderSoundVolume = _sliderSoundVolume;
@synthesize timerClose = _timerClose;
@synthesize SoundButton = _SoundButton;

- (id)init
{
    self = [super initWithNibName:@"VolumeBar" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLblSoundName:nil];
    [self setSliderSoundVolume:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)show:(id)sender{
    self.SoundButton = sender;
    self.lblSoundName.text = [sender soundName];
    self.sliderSoundVolume.value = [sender relativeVolume]*[sender mainVolume];
    [UIView animateWithDuration:1.0 
                     animations:^{
                         self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
                     }];
    [self.view.superview bringSubviewToFront:self.view];
    self.timerClose = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}
- (void)hide{
    [UIView animateWithDuration:1.0 
                     animations:^{
                         self.view.center = CGPointMake(self.view.frame.size.width/2, -self.view.frame.size.height/2);
                     }
                     completion:^(BOOL finished) {                         
                         self.SoundButton = nil;
                         self.lblSoundName.text = @"";
                         self.sliderSoundVolume.value = 1;
                     }];    
}

- (IBAction)close:(id)sender {
    [self.timerClose invalidate];
    self.timerClose=nil;
    [self hide];
}

- (IBAction)sliderValueChanged:(id)sender {
    [self.timerClose invalidate];    
    self.timerClose = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
    if (self.sliderSoundVolume.value > [self.SoundButton mainVolume]) {
        self.sliderSoundVolume.value = [self.SoundButton mainVolume];
    }else {        
        [self.SoundButton setRelativeVolume:(self.sliderSoundVolume.value/[self.SoundButton mainVolume])];
    }
}
@end
