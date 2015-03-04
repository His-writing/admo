
#import "SZImageView.h"

@implementation SZImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initViews];
}

-(void)initViews
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.touchBlock) {
        _touchBlock();
    }
}

@end
