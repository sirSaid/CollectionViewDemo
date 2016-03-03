
//  WaterLayout.m
//  CollectionDemo
//
//  Created by lanou3g on 15/11/30.
//  Copyright (c) 2015年 十三先生. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout ()

// item的数量
@property (nonatomic,assign)NSInteger numOfItems;

// 保存每列的高度
@property (nonatomic,strong)NSMutableArray *columnHeights;
// 保存item属性的数组
@property (nonatomic,strong)NSMutableArray *itemAttributes;

// 获取最长列的索引(下标)
-(NSInteger)P_indexForLongestColumn;

// 获取最段列的索引
-(NSInteger)p_indexForShortestColumn;

@end

@implementation WaterLayout

#pragma mark -------  懒加载
-(NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)itemAttributes
{
    if (!_itemAttributes) {
        _itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

#pragma mark ---- 获取最长和最短列的索引
-(NSInteger)P_indexForLongestColumn
{
    // 记录哪个是最长的
    NSInteger logestHeight = 0;
    // 记录最长的item的下标via哦
    NSInteger longestIndex = 0;
    // 遍历
    for (int i = 0; i < self.numberOfColumn; i++) {
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (logestHeight < currentHeight) {
            logestHeight =  currentHeight;
            longestIndex = i;
        }
    }
    return longestIndex;
}

-(NSInteger)p_indexForShortestColumn
{
    // 记录最短列的索引
    NSInteger shortestItemIndex = 0;
    
    // 计算最短高度
    CGFloat shortestHeight = MAXFLOAT;// 浮点型最大值的宏
    
    // 循环找到最短列的索引
    for (int i = 0; i < self.numberOfColumn; i++) {
        // 获取当前的列的高
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        // 判断找到最短的高
        if (currentHeight < shortestHeight) {
            shortestHeight = currentHeight;
            shortestItemIndex = i;
        }
    }
    return shortestItemIndex;
}

#pragma mark ------ 设置属性
-(void)prepareLayout
{
    // 执行父类的方法
    [super prepareLayout];
    
    // 给高度数组赋值
    for (int i = 0; i < self.numberOfColumn; i++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    // 获取所有的item的个数
    self.numOfItems = [self.collectionView numberOfItemsInSection:0];
    // 给每一个item设置frame
    for (int i = 0; i < self.numOfItems; i++) {
        // 获取到高度最小的列
        NSInteger shortIndex = [self p_indexForShortestColumn];
        // 获取最小列的最小高度
        CGFloat shortHeight = [self.columnHeights[shortIndex] floatValue];
        
        // 设置frame的X left+(item间距+item宽)*列的索引
        CGFloat detalX = self.sectionInsets.left + (self.itemSize.width+self.insetItemSpacing)*shortIndex;
        
        // 设置Y 最短列的高度加上间隙
        CGFloat detalY = shortHeight + self.insetItemSpacing;
        
        // 设置indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 创建 LayoutAttributes对象
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        // 获取item的高度(需要根据解析的数据传过来)
        CGFloat itemHeight = 0;
        if ([self.delegate respondsToSelector:@selector(heightForItemIndexPath:)]) {
            itemHeight = [self.delegate heightForItemIndexPath:indexPath];
        }
        
        //设置attributes的frame
        attributes.frame = CGRectMake(detalX, detalY, self.itemSize.width, itemHeight);
        // 添加到数组中  用于layoutAttributesForElementsInRect方法的返回值,从而根据数组设置来设置每个item
        [self.itemAttributes addObject:attributes];
        
        // 更新数组高度
        self.columnHeights[shortIndex] = @(detalY+itemHeight);
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

// 设置collectionView的contentSize(大小)
-(CGSize)collectionViewContentSize
{
    // 获取最长列的索引
    NSInteger longestIndex = [self P_indexForLongestColumn];
    // 获取最长列的最长长度
    CGFloat longestHeight = [self.columnHeights[longestIndex] floatValue];
    // 最长长度+距下的间隙
    CGFloat height = longestHeight + self.sectionInsets.bottom;
    
    // 修改contentSize
    CGSize contentSize = self.collectionView.frame.size;
    contentSize.height = height;
    // 返回
    return contentSize;
}





@end
