
#import "SZBannerView.h"
#import "QYYLgoogleLib.H"
@implementation SZBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        arr_AdTitles=[[NSArray alloc]initWithObjects:@"dmn", @"dk",@"dknv",@"dnvj",nil];
        
        
        arr_adContent=[[NSArray alloc]initWithObjects:@"svn", @"dknv",@"dkvjk",@"dklfv",nil];
        
        [self initBannerCycleView];
        
        
        
        
        
        
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initBannerCycleView];
}

-(void)initBannerCycleView
{
    self.mainScorllView = [[SZScrollView alloc] initWithFrame:self.bounds animationDuration:3];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    
    titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, self.mainScorllView.frame.size.height+10,25, 20.f)];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10.f]];
           [titleLable setText:[arr_AdTitles objectAtIndex:0]];
    
    

    
    
    
//    titleLable.text=@"推荐";
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    titleLable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    
    [self addSubview: titleLable];
    
    titleContent=[[UILabel alloc]initWithFrame:CGRectMake(titleLable.frame.size.width+titleLable.frame.origin.x+3, titleLable.frame.origin.y, 200, titleLable.frame.size.height)];
    
    [titleContent setBackgroundColor:[UIColor clearColor]];
    [titleContent setTextColor:[UIColor blackColor]];
    [titleContent setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.f]];
            [titleContent setText:[arr_adContent objectAtIndex:0]];
    
//    titleContent.text=@"dnkdvndfmbvdfbvjdf";
    [titleContent setTextAlignment:NSTextAlignmentLeft];
    
    [self addSubview:titleContent];
    

    
    
    __weak SZBannerView *this = self;
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return [this arrayImageIndex:pageIndex];
    };
    
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return this.listArray.count;
    };
    
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        this.aDidClickPageBlock(pageIndex);
    };
    
    [self addSubview:self.mainScorllView];
    [self.mainScorllView reloadData];

}

-(void)setListArray:(NSArray *)listArray
{
  
    
    if ([listArray count]>0) {
        if (_listArray != listArray) {
            _listArray = listArray;
            [self.mainScorllView reloadData];
        }
    }

}

-(UIImageView *)arrayImageIndex:(long)index
{
    if (_listArray.count<=0) {
        return nil;
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    imageView.userInteractionEnabled = YES;
    
    NSString *imageUrlString = [_listArray objectAtIndex:index];
    
    [[QYYLgoogleLib getQYYLGooglelib]QYYLGADInterstitial];

    titleLable.text=[arr_AdTitles objectAtIndex:index];
    titleContent.text=[arr_adContent objectAtIndex:index];
//    [imageView setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"home_banner_default.png"]];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]  placeholderImage:nil];
    
    return imageView;
}

@end
