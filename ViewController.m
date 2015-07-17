
//
//  ViewController.m
//  admo
//
//  Created by shuzhenguo on 15-2-6.
//  Copyright (c) 2015年 shuzhenguo. All rights reserved.
//郭树振

#import "ViewController.h"

#import "QYYLgoogleLib.H"
@interface ViewController ()

@end

@implementation ViewController




-(void)initlize{
    
    [[QYYLgoogleLib getQYYLGooglelib]initHomeViewController:self QYYLGoogleBannerViewAdUnitID:@"" interstitialAdUnitID:@"" bannerY:0 bannerX:0];
    
    
    
    
    [[QYYLgoogleLib getQYYLGooglelib]QYYLGADBannerView];
    
    
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
    
    
    [self initHeadBannerView];
    [self initWithSubview];
    
}

-(void)initHeadBannerView
{
    
    
    NSArray *arra=[[NSArray alloc]initWithObjects:@"", @"",@"",@"",nil];
    
    
    if ([arra count]>0) {
        
        self.bannerView = [[SZBannerView alloc] initWithFrame:CGRectMake(0, 90, 320, 180)];
        __weak ViewController *this = self;
        self.bannerView.aDidClickPageBlock = ^(int index){
            [this bestGameIntroduce:index];
        };
        _bannerView.listArray = arra;
    }
    
    
    
    [self.view addSubview:_bannerView];
    
    
    
}
- (void)bestGameIntroduce:(int)index
{
    [[QYYLgoogleLib getQYYLGooglelib]QYYLGADInterstitial];

    
    NSLog(@"---%d",index);
    
    
}
- (void)initWithSubview
{
    self.hotCardsScrollView.contentSize = CGSizeMake(90 * 5 + 10, 150);
    
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 5; i ++) {
        self.surveyView = [[[NSBundle mainBundle] loadNibNamed:@"GameSurveyView" owner:self options:nil] lastObject];
        self.surveyView.frame = CGRectMake(5+60 * i, 0, 60, 90);
        self.surveyView.backgroundColor = [UIColor redColor];
        self.surveyView.tag = 1024 + i;
        [self.hotCardsScrollView addSubview:self.surveyView];
    }
}



- (void)layoutSubviews
{
    
    
//    for (int i = 0; i < 10; i ++) {
////        GameSurveyView *gameView = (GameSurveyView *)[self.view viewWithTag:1024+i];
////        HomeGameModel *everyModel = self.data[i];
////        gameView.model = everyModel;
////        if (_cellButtonShowMore == cellButtonShowHotCards) {
////            gameView.surveyType = GameSurveyViewHot;
////        }else{
////            gameView.surveyType = GameSurveyViewNew;
////        }
////        [gameView setNeedsLayout];
//    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
