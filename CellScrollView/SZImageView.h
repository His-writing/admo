
#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(void);

@interface SZImageView : UIImageView

@property(nonatomic, copy)ImageBlock touchBlock;

@end
