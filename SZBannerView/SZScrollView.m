
#import "SZScrollView.h"
#import "NSTimer+Addition.h"
#import "SZPageControl.h"
#import "UIViewExt.h"
@interface SZScrollView () <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic, strong) SZPageControl *customPageControl;

@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation SZScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    
    if (totalPagesCount!= _totalPagesCount) {
        _totalPagesCount = totalPagesCount;
    }
    _totalPageCount = totalPagesCount();
    
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        self.customPageControl = [[SZPageControl alloc] initWithType:DDPageControlTypeOnFullOffFull];
        
        self.customPageControl.frame=CGRectMake(self.width-60, self.height, 111, 20);
        

        self.customPageControl.userInteractionEnabled=NO;
        self.customPageControl.backgroundColor=[UIColor clearColor];
        self.customPageControl.numberOfPages=0;
        self.customPageControl.currentPage=0;
        self.customPageControl.onColor=[UIColor yellowColor];
        self.customPageControl.offColor=[UIColor grayColor];
        self.customPageControl.indicatorSpace=6;
        self.customPageControl.indicatorDiameter=6;
        
        [self.scrollView addSubview:_customPageControl];
        
        
//        titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, self.height+5,25, 20.f)];
//        [titleLable setTextColor:[UIColor whiteColor]];
//        [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10.f]];
////        [titleLable setText:[arr_AdTitles objectAtIndex:0]];
//        titleLable.text=@"推荐";
//        [titleLable setTextAlignment:NSTextAlignmentCenter];
//        titleLable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
//
//
//        [self addSubview: titleLable];
//        
//        titleContent=[[UILabel alloc]initWithFrame:CGRectMake(titleLable.frame.size.width+titleLable.frame.origin.x+3, titleLable.frame.origin.y, 200, titleLable.frame.size.height)];
//        
//        [titleContent setBackgroundColor:[UIColor clearColor]];
//        [titleContent setTextColor:[UIColor blackColor]];
//        [titleContent setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.f]];
////        [titleContent setText:[arr_adContent objectAtIndex:0]];
//        
//        titleContent.text=@"dnkdvndfmbvdfbvjdf";
//        [titleContent setTextAlignment:NSTextAlignmentLeft];
//        
//        [self addSubview:titleContent];
//
        
        
        

    }
    return self;
}

- (void)reloadData
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];

    _totalPageCount = _totalPagesCount();
    
    if (_totalPageCount == 0) {
        [self.customPageControl removeFromSuperview];
        return;
    }
    if (_totalPageCount == 1) {
        _scrollView.scrollEnabled = NO;
        [self.customPageControl removeFromSuperview];
    } else {
        _scrollView.scrollEnabled = YES;
        if (!_customPageControl.superview) {
            [self addSubview:_customPageControl];
        }
    }
    _customPageControl.numberOfPages = _totalPageCount;
    
    [self configContentViews];
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    
    self.customPageControl.currentPage = _currentPageIndex;

    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
//    titleLable.frame=CGRectMake(_scrollView.frame.size.width, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
}

//DidEndDecelerating 减速停止的时候开始执行

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];

}


#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
    
    
//    NSLog(@"%d,",self.currentPageIndex);
    
    
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:2];
//
//    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:titleLable cache:YES];
//    [UIView setAnimationDelegate:self];
//
//    
//    [UIView commitAnimations];
    
//    titleLable.frame=CGRectMake(self.width, self.height,25, 20.f);
//
//    
//    [UIView animateWithDuration:0.6f animations:^{
//        
//        titleLable.frame=CGRectMake(10, self.height,25, 20.f);
//        
//    }];
//
    
    
//    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}


@end
