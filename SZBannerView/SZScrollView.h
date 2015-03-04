//
//  CycleScrollView.h
//  PagedScrollView
//
//  Created by lihong on 14-2-18.
//  Copyright (c) 2014年 ihandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZScrollView : UIView
{
    
//    UILabel *titleLable;  // 广告标题
//    UILabel *titleContent;
    
}
@property (nonatomic , readonly) UIScrollView *scrollView;
@property (nonatomic , strong) NSTimer *animationTimer;

/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
- (void)reloadData;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end