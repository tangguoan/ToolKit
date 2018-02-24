//
//  UIImage+utils.h
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (utils)

- (UIImage *)fq_imageToSize:(CGSize) size;

- (NSData *)fq_JPEGRepresentationWithCompressionSize:(long long )size;

- (UIImage*)fq_grayImage;

- (UIImage *)fq_imageWithRenderingOriginal;

+ (UIImage *)fq_imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                      borderWidth:(CGFloat)borderWidth
                     cornerRadius:(CGFloat)cornerRadius;

/////////////////////////////////////////////

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)borderColor
                       innerColor:(UIColor *)innerColor
                     cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)borderColor
                      borderWidth:(CGFloat)borderWidth
                       innerColor:(UIColor *)innerColor
                     cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)fq_imageWithView:(UIView*)aView;

- (UIImage *)fq_imageByApplyingAlpha:(CGFloat)alpha;

- (UIImage *)fq_highlightImage;

+ (UIImage *)fq_imageWithColor:(UIColor *)color size:(CGSize)imgSize;
- (UIImage *)fq_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
- (UIImage *)fq_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)fq_imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *)fq_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
+ (UIImage *)fq_imageFromView:(UIView *)aView;
+ (UIImage *)fq_imageFromAttributtedText:(NSAttributedString *)aAtt size:(CGSize)size;
- (UIImage *)fq_imageWithTextMask:(NSAttributedString *)attributedText;

- (UIImage *)fq_roundedRectImageWithSize:(CGSize)size radius:(int)radius;
@end
