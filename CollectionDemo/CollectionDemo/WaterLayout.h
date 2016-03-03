
#import <UIKit/UIKit.h>

@protocol waterLayoutDelegate <NSObject>

-(CGFloat)heightForItemIndexPath:(NSIndexPath*)indexPath;

@end

@interface WaterLayout : UICollectionViewLayout

@property (nonatomic,weak) id<waterLayoutDelegate>delegate;
// item的大小
@property (nonatomic,assign) CGSize itemSize;

// 距离屏幕边缘的边距
@property (nonatomic,assign) UIEdgeInsets sectionInsets;

// item之间的间距
@property (nonatomic,assign) CGFloat insetItemSpacing;

// 列数
@property (nonatomic,assign) NSInteger numberOfColumn;

@end
