
#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}

-(void)allViews
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
    [self.contentView addSubview:self.imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
