//
//  mainContent.m
//  Relax
//
//  Created by Dat Nguyen on 5/16/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "MainContent.h"
#import "objSoundItem.h"

@interface MainContent ()
@property (strong, nonatomic) NSMutableArray *soundButtonArray;
@property (strong, nonatomic) NSMutableArray *ropeArray;
@property (nonatomic) int numberRows;
@property (nonatomic) int numberColumns;
@property (nonatomic) float margin;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)changePage:(id)sender;
@end

@implementation MainContent
#pragma mark - Encapsulation
@synthesize soundButtonArray = _soundButtonArray;
@synthesize ropeArray = _ropeArray;
@synthesize numberRows = _numberRows;
@synthesize numberColumns = _numberColumns;
@synthesize margin = _margin;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize viewFrame = _viewFrame;
@synthesize delegate = _delegate;
- (void)setViewFrame:(CGRect)viewFrame{
    _viewFrame = viewFrame;
    self.view.frame = viewFrame;
    //Set layout for sound button
    [self layoutSoundButton];
    [self layoutRope];
}

#pragma mark - Construction
- (id)initWithSoundArray:(NSArray *)sounds Frame:(CGRect)frame{
    self = [super initWithNibName:@"mainContent" bundle:nil];
    if (self) {
        //load sound name from plist
        self.soundButtonArray = [[NSMutableArray alloc] init ];
        self.ropeArray = [[NSMutableArray alloc] init ];
        [self createSoundButtons:sounds];
        self.numberRows = 5;
        self.numberColumns = 7;
        self.margin = 30;
        self.viewFrame = frame;
    }
    return self;
}

- (void)createSoundButtons:(NSArray *)sounds{
    
    for (id soundItem in sounds) {
        
        if ([soundItem isMemberOfClass:[objSoundItem class]]) {            
            SoundButton *newSB = [[SoundButton alloc] initWithName:[soundItem name] 
                                                        DefaultImg:[soundItem defaultImage] 
                                                       SelectedImg:[(objSoundItem *)soundItem selectedImage] 
                                                         SoundFile:[soundItem soundFile]];
            [self.soundButtonArray addObject:newSB];
            newSB.delegate = self;
        }  
    }
}

#pragma mark - Layout Handling
- (void)layoutSoundButton{
    int numberPages = ceil((double)self.soundButtonArray.count/(double)(self.numberRows*self.numberColumns));

    //Set number pages for scroll view
    self.pageControl.numberOfPages = numberPages;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * numberPages,self.scrollView.frame.size.height);
    if (self.soundButtonArray.count > 0) {
        float soundwidth = (self.scrollView.frame.size.width - 2*self.margin)/self.numberColumns;
        float soundheight = self.scrollView.frame.size.height/self.numberRows;
        int x = 0;
        int y = 0;
        int page = 0;
        for (id soundBttItem in self.soundButtonArray) {
            if ([soundBttItem isMemberOfClass:[SoundButton class]]) {
                [soundBttItem setViewFrame:CGRectMake(x*soundwidth+ self.margin + page*self.scrollView.frame.size.width, y*soundheight, soundwidth, soundheight)];
                x++;
                if (x==self.numberColumns) {
                    x=0;
                    y++;
                    if (y==self.numberRows) {
                        page++;
                        y=0;
                    }
                }
            }
        }
    }
}

- (void)layoutRope{
    //Clear rope array
    for (id ropeItem in self.ropeArray) {
        [ropeItem removeFromSuperview];
    }
    [self.ropeArray removeAllObjects];
    //Creat rope
    for (int i=0; i<self.pageControl.numberOfPages-1; i++) {
        for (int j=0; j<self.numberColumns; j++) {            
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rope.png"]];
            float cellWidth = (self.scrollView.frame.size.width-2*self.margin)/self.numberColumns;
            float ropeHeight = self.scrollView.frame.size.height - 0.5*(self.scrollView.frame.size.height/self.numberRows);
            imgView.frame = CGRectMake(i*self.scrollView.frame.size.width + j*cellWidth + self.margin + cellWidth/2 - imgView.image.size.width/2, 0, imgView.image.size.width, ropeHeight);
            [self.scrollView addSubview:imgView];
            [self.ropeArray addObject:imgView];
        }
    }   
    
    //Draw rope for last page
    int numberSoundOfLastPage = self.soundButtonArray.count-self.numberColumns*self.numberRows*(self.pageControl.numberOfPages-1);
    int numberRopeOfLastPage = (numberSoundOfLastPage>7)?7:numberSoundOfLastPage;
    for (int i = 0; i<numberRopeOfLastPage; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rope.png"]];
        float cellWidth = (self.scrollView.frame.size.width-2*self.margin)/self.numberColumns;
        int numberSoundOfRope = floor((float)(numberSoundOfLastPage-(i+1))/(float)(self.numberColumns))+1;
        float ropeHeight = (self.scrollView.frame.size.height/self.numberRows) * numberSoundOfRope - 0.5*(self.scrollView.frame.size.height/self.numberRows);
        imgView.frame = CGRectMake((self.pageControl.numberOfPages-1)*self.scrollView.frame.size.width+i*cellWidth + self.margin + cellWidth/2 - imgView.image.size.width/2, 0, imgView.image.size.width, ropeHeight);
        [self.scrollView addSubview:imgView];
        [self.ropeArray addObject:imgView];
    }
    
    for (id soundBtt in self.soundButtonArray) {
        [self.scrollView bringSubviewToFront:[soundBtt view]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showSoundButtons];
    //Play random sounds
    [self playRandom];
}

- (void)showSoundButtons{
    for (id soundBtt in self.soundButtonArray) {
        if ([self.view.subviews indexOfObject:[soundBtt view]] == NSNotFound) {            
            [self.scrollView addSubview:[soundBtt view]];
        }
    }
}

- (void)playRandom{
    NSMutableArray *randomArr = [self.soundButtonArray mutableCopy];
    for (int i=0; i<=4; i++) {
        int randomIndex = arc4random() % randomArr.count;
        [[randomArr objectAtIndex:randomIndex] setSelected:YES];
        [randomArr removeObject:[randomArr objectAtIndex:randomIndex]];
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Event Handling
- (IBAction)changePage:(id)sender {
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.pageControl.currentPage, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = ceil(scrollView.contentOffset.x/scrollView.frame.size.width);
}

- (void)soundButtonDidTouched:(id)sender{
    [self.delegate mainContentDidTouchedSoundButton:sender];
    [self play];
}

- (void)play{    
    for (id soundBttItem in self.soundButtonArray) {
        if ([soundBttItem selected]) {
            [soundBttItem play];
        }
    }
}

- (void)pause{  
    for (id soundBttItem in self.soundButtonArray) {
        if ([soundBttItem selected]) {
            [soundBttItem pause];
        }
    }
}

- (void)changeVolume:(float)value{   
    for (id soundBttItem in self.soundButtonArray) {
        [soundBttItem changeVolume:value];
    } 
}

- (void)clear{
    for (id soundBttItem in self.soundButtonArray) {
        if ([soundBttItem selected]) {
            [soundBttItem setSelected:NO];
        }
    }
}
@end
