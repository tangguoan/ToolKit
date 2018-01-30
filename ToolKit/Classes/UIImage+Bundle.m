//
//  UIImage+Bundle.m
//  Pods
//
//  Created by tangguoan on 2017/3/16.
//
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)

+(UIImage *)load_imageNamed:(NSString *)name;
{


    NSBundle *main =  [NSBundle bundleForClass:[self class]];

    if (name.length == 0) {
        return nil;
    }
    NSString *imgName = [NSString stringWithFormat:@"ToolKit.bundle"];
    imgName = [imgName stringByAppendingPathComponent:name];
    return  [UIImage imageNamed:imgName];
}
@end
