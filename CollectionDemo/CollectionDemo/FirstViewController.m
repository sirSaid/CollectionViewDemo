
#import "FirstViewController.h"
#import "ImageCell.h"
#import "DataHandle.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
#import "WaterLayout.h"

@interface FirstViewController ()<UICollectionViewDataSource,waterLayoutDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterLayout *layout = [[WaterLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 0); // 图片大小
    layout.insetItemSpacing = 20; // 间隙
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10); // 距离四边的距离
    layout.numberOfColumn = 3; // 列数
    
    // 设置代理
    layout.delegate = self;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    // 加载数据
    [[DataHandle sharedHandle] getData];
    
    // 设置标记
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"imageCell"];
}
#pragma mark -- 实现dataSource的协议方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[DataHandle sharedHandle].dataAray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Model *model = [[Model alloc] init];
    model = [DataHandle sharedHandle].dataAray[indexPath.item];
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"20.png"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbURL]];
    
    NSLog(@"%@",model);
    return cell;
}

#pragma mark ---- 自定义协议方法的实现
-(CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath
{
    Model *mod = [DataHandle sharedHandle].dataAray[indexPath.item];
    CGFloat w = [mod.width floatValue];
    CGFloat h = [mod.height floatValue];
    CGFloat itemw = ([UIScreen mainScreen].bounds.size.width - 70)/3;
    CGFloat itemh = h/w*itemw;
    return itemh;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
