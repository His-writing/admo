//
//  ViewController.h
//  admo
//
//  Created by shuzhenguo on 15-2-6.
//  Copyright (c) 2015年 shuzhenguo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ScrollFocusImageView.h"
#import "SZBannerView.h"
#import "GameSurveyView.h"
@interface ViewController : UIViewController


@property (nonatomic, retain) SZBannerView *bannerView;

-(void)initlize;

@property (weak, nonatomic) IBOutlet UIScrollView *hotCardsScrollView;

@property(nonatomic,strong)GameSurveyView *surveyView;


@end
