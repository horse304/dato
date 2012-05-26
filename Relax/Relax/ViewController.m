//
//  ViewController.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "Config.h"
#import "ViewController.h"
#import "GetImages.h"
#import "GetFileURLs.h"
#import "Background.h"
#import "Toolbar.h"
#import "Cloud.h"
#import "GrowingStar.h"
#import "VolumeBar.h"
#import "MainContent.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (strong, nonatomic) IBOutlet UIView *viewToolbar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) Background *myBackground;
@property (strong, nonatomic) Toolbar *myToolBar;
@property (strong, nonatomic) VolumeBar *myVolumeBar;
@property (strong, nonatomic) MainContent *myContent;
@property (strong, nonatomic) NSMutableArray *cloudArray;
@property (strong, nonatomic) NSMutableArray *starArray;

@end

@implementation ViewController
#pragma mark - Encapsulation
@synthesize viewBackground=_imgBG;
@synthesize viewToolbar=_customToolBar;
@synthesize viewContent = _viewContent;
@synthesize myBackground = _myBackground;
@synthesize myToolBar = _myToolBar;
@synthesize myVolumeBar = _myVolumeBar;
@synthesize myContent = _myContent;
@synthesize cloudArray = _cloudArray;
@synthesize starArray = _starArray;
@synthesize modelController = _modelController;

#pragma mark - Layout handling
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //----*************  Always Portrait ************--------//
    //Initial background view controller and set view
    Background *newBG = [[Background alloc] initWithNibName:@"Background" bundle:nil];
    [self setMyBackground:newBG];
    self.myBackground.imgLandscapes = [GetImages getBackgroundLandscapes];
    self.myBackground.imgPortraits = [GetImages getBackgroundPortraits];
    [[self viewBackground] addSubview:[[self myBackground] view]];
    self.myBackground.view.frame = self.viewBackground.bounds;
        
    //Initial toolbar view controller and set view, set delegate
    Toolbar *newToolbar = [[Toolbar alloc] initWithNibName:@"Toolbar" bundle:nil];
    [self setMyToolBar:newToolbar];    
    [self.myToolBar setDelegate:self];
    [[self viewToolbar] addSubview:[[self myToolBar] view]];
    self.myToolBar.view.frame = self.viewToolbar.bounds;
    [self.myToolBar setPlaying:NO];   
    
    //Initial main content
    MainContent *newMC = [[MainContent alloc] initWithSoundArray:self.modelController.soundArray Frame:self.viewContent.bounds];
    self.myContent = newMC;
    self.myContent.delegate = self;
    [self.viewContent addSubview:self.myContent.view];
    [self.myContent changeVolume:self.myToolBar.volumeValue];
    
    //Initial volume bar
    VolumeBar *newVB = [[VolumeBar alloc] init];
    self.myVolumeBar = newVB;
    self.myVolumeBar.view.frame = CGRectMake(0, -24, self.view.frame.size.width, 24);
    [self.view addSubview:self.myVolumeBar.view];
    
	//Start clouds, stars
    [self showClouds];
    [self showStars];
    [self.view bringSubviewToFront:self.viewContent];
    [self.viewContent bringSubviewToFront:self.myContent.view];
    
}

- (void)viewDidUnload
{
    [self setMyBackground:nil];
    [self setMyToolBar:nil];
    [self setMyContent:nil];
    [self setViewBackground:nil];
    [self setViewToolbar:nil];
    [self setViewBackground:nil];
    [self setViewContent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    //In this method, should change properties like image of subviews    
    
    [self.myBackground willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];    
    [self.myToolBar willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //In this method, should only set layout for subviews
    if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        [self setLayoutLandscape];
    }else {
        [self setLayoutPortrait];
    }    
        [self showClouds];
        [self showStars];    
        [self.viewContent bringSubviewToFront:self.myContent.view];
}
 
 
- (void)setLayoutLandscape{
    float screenwidth = self.view.bounds.size.width;
    float screenheight = self.view.bounds.size.height;
    self.viewToolbar.frame = CGRectMake(0, screenheight - 250, screenwidth, 250);

    self.viewContent.frame = CGRectMake(0, 0, screenwidth, screenheight - self.viewToolbar.frame.size.height+50);
    self.myContent.viewFrame = self.viewContent.frame;
    self.myVolumeBar.view.frame = CGRectMake(0, -24, screenwidth, 24);
}
 
- (void)setLayoutPortrait{    
    float screenwidth = self.view.bounds.size.width;
    float screenheight = self.view.bounds.size.height;
    self.viewToolbar.frame = CGRectMake(0, screenheight - 250, screenwidth, 250);

    self.viewContent.frame = CGRectMake(0, 0, screenwidth, (screenheight - self.viewToolbar.frame.size.height)+50);      
    self.myContent.viewFrame = self.viewContent.frame;     
    self.myVolumeBar.view.frame = CGRectMake(0, -24, screenwidth, 24);
}

- (void)showClouds{  
    if (!self.cloudArray) {
        self.cloudArray = [[NSMutableArray alloc] init];
    }
    //Remove old clouds
    for (Cloud *objCloud in self.cloudArray) {
        [objCloud.view removeFromSuperview];
    }
    [self.cloudArray removeAllObjects];
    NSArray *cloudImgs = [GetImages getCloudImages];
    NSMutableArray *pickNumber = [[NSMutableArray alloc] init];
    for (int i=0;i<cloudImgs.count; i++) {
        NSNumber *newNumber = [NSNumber numberWithInt:i];
        [pickNumber addObject:newNumber];
    }
    for (int i=0;i<cloudImgs.count;i++) {
        UIImage *img = [cloudImgs objectAtIndex:i];
        CGRect cloudFrame = CGRectMake(0, i*(int)(self.viewContent.bounds.size.height/cloudImgs.count), self.viewContent.bounds.size.width, (int)(self.viewContent.bounds.size.height/cloudImgs.count));
        NSNumber *cloudOrder = [pickNumber objectAtIndex:(arc4random() % pickNumber.count)];
        Cloud *newCloud = [[Cloud alloc] initWithCloudImage:img frame:cloudFrame order:[cloudOrder intValue]];
        [pickNumber removeObject:cloudOrder];
        [self.cloudArray addObject:newCloud];
        [self.viewContent addSubview:newCloud.view];
    }
}

- (void)showStars{
    if (!self.starArray) {
        self.starArray = [[NSMutableArray alloc] init];
    }
    for (GrowingStar *star in self.starArray) {
        [star.view removeFromSuperview];
    }
    NSMutableArray *xArray = [NSMutableArray arrayWithObjects:
                         [NSNumber numberWithInt:0],
                         [NSNumber numberWithInt:1],
                         [NSNumber numberWithInt:2],nil];
    NSMutableArray *yArray = [NSMutableArray arrayWithObjects:
                         [NSNumber numberWithInt:0],
                         [NSNumber numberWithInt:1],
                         [NSNumber numberWithInt:2],nil];
    [self.starArray removeAllObjects];
    for (int i=0; i<3; i++) {
        NSNumber *starX = [xArray objectAtIndex:(arc4random() % xArray.count)];
        NSNumber *starY = [yArray objectAtIndex:(arc4random() % yArray.count)];
        
        float width = self.viewContent.bounds.size.width/3;
        float height = self.viewContent.bounds.size.height/3;
        int x = (int)(width * [starX intValue] + width/2);
        int y = (int)(height * [starY intValue] + height/2);        
        
        GrowingStar *newstar = [[GrowingStar alloc] initWithCenterPoint:CGPointMake(x, y)];
        [xArray removeObject:starX];
        [yArray removeObject:starY];
        [self.starArray addObject:newstar];
        [self.viewContent addSubview:[newstar view]];
    }    
}


#pragma mark - Event Handling
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self.myContent clear];
    [self.myContent playRandom];
}
- (void)applicationDidBecomeActive{
    for (id cloud in self.cloudArray) {
        [cloud startAnimation];
    }  
    for (id star in self.starArray) {
        [star startAnimation];
    } 
}

- (void)applicationWillResignActive{
    for (id cloud in self.cloudArray) {
        [cloud pauseAnimation];
    } 
    for (id star in self.starArray) {
        [star pauseAnimation];
    } 
}

- (void)mainContentDidTouchedSoundButton:(id)sender{
    self.myToolBar.Playing = YES;
    //Show volume bar for this sound
    [self.myVolumeBar show:sender];
}

- (void)toolbarDidChangePlaying:(BOOL)Playing{
    if (Playing) {
        [self.myContent play];
    }else {
        [self.myContent pause];
    }  
}
- (void)toolbarDidChangeVolume:(float)value{
    [self.myContent changeVolume:value];
}
- (void)toolbarTouchedClear{
    [self.myContent clear];
}
- (void)toolbarTouchedClock{
    
}

@end
