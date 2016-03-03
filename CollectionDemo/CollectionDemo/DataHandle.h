

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject

+(DataHandle *)sharedHandle;

@property (nonatomic,strong) NSMutableArray *dataAray;

-(void)getData;

@end
