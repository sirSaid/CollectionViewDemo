
#import "ViewController.h"
#import "ImageCell.h"
#import "LineLayout.h"
#import "DataHandle.h"
#import "Model.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LineLayout *layout = [[LineLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    // 代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 设置重用标志
    [collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"imageCell"];
    // 加载数据
    [[DataHandle sharedHandle] getData];
    
}
#pragma mark ---- UICollectionViewDataSource 协议
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [DataHandle sharedHandle].dataAray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Model *model = [[Model alloc] init];
    model = [DataHandle sharedHandle].dataAray[indexPath.item];
    
    // 创建
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"4.png"];
    //  使用UIImageView+WebCache.h 的方法sd_setImageWithURL
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbURL]];
    
    return cell;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
