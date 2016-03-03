

#import "LineLayout.h"

#define KItemX 100
#define KItemY 100

@interface LineLayout ()

@property (nonatomic,strong)NSArray *array;

@end

@implementation LineLayout

// 懒加载
-(NSArray *)array
{
    if (!_array) {
        self.array = [NSArray array];
    }
    return _array;
}

// 配置layout基本属性
-(void)prepareLayout
{
    // 行间距
    self.minimumLineSpacing = 50;
    // item 直接的间距
    self.itemSize = CGSizeMake(KItemX, KItemY+20);
    //设置滚动横屏
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置距离屏幕边缘的位置
    CGFloat top = (self.collectionView.frame.size.height - KItemX)/2;
    CGFloat left = (self.collectionView.frame.size.width - KItemX)/2;
    
    self.sectionInset = UIEdgeInsetsMake(top, left, top, left);
}

// 是否时刻改变布局的方法  默认是
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    NSLog(@"是否时刻改变布局");
    return YES;
}

// 配置一个item的相关属性(获得所有属性的方法)
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"配置一个item的相关属相");
    _array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in _array) {
        //设置偏移量
        // 显示正中间的位置
        CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
        // 其中一个对象的中心点
        CGFloat itemcenterX = attributes.center.x;
        
        // 设置缩放比例
        CGFloat scale = 1 + 0.5*(1 - ABS(centerX - itemcenterX)/150);
        
        // 设置transform3D
        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1.2);
    }
    
    return _array;
}

@end
