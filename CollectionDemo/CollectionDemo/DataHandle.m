//

#import "DataHandle.h"
#import "Model.h"

static DataHandle *dataHandle = nil;
@implementation DataHandle

+(DataHandle *)sharedHandle
{
    @synchronized(self){
        if (nil == dataHandle) {
            dataHandle = [[DataHandle alloc] init];
        }
    }
    return dataHandle;
}

-(void)getData
{
    // 文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
    // 转成data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // json解析
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // 遍历
    self.dataAray = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        // 创建model对象
        Model *model = [[Model alloc] init];
        // 将dic转成model对象
        [model setValuesForKeysWithDictionary:dic];
        // 添加到dataArray
        [self.dataAray addObject:model];
    }
    
}




@end
