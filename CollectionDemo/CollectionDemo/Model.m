
#import "Model.h"

@implementation Model

-(NSString *)description
{
    return [NSString stringWithFormat:@"thumbURL:%@,width:%@,height:%@",self.thumbURL,self.width,self.height];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
