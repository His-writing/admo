
#import <UIKit/UIKit.h>
//#import "SFHttpRequest.h"
//#import "NSDictionary+Utils.h"
#import "UIImageView+WebCache.h"
//#import "AppUtil.h"
#import "SZScrollView.h"
typedef  void (^didClickPageBlock) (int index);


@interface SZBannerView : UIView
{
    UILabel *titleLable;  // 广告标题
    UILabel *titleContent;
    
    NSArray *arr_AdTitles;   // 广告标题
    
    NSArray *arr_adContent;


}

@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) NSArray *advertiseArray;



@property (nonatomic, copy) didClickPageBlock aDidClickPageBlock;

@property (nonatomic,strong) SZScrollView *mainScorllView;
@end
