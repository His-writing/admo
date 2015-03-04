//
//  GameSurveyView.m
//  addemo_gun
//
//  Created by shuzhenguo on 15-2-8.
//  Copyright (c) 2015年 shuzhenguo. All rights reserved.
//

#import "GameSurveyView.h"
#import "UIImageView+WebCache.h"
@implementation GameSurveyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://app.yilegame.com/upload/picture/banner/2014_12_22_18_14_02_403443.png"] placeholderImage:nil];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
