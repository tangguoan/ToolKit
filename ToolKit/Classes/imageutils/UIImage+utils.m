//
//  UIImage+utils.m
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import "UIImage+utils.h"
#import <Accelerate/Accelerate.h>

CGMutablePathRef fq_createRoundedCornerPath(CGRect rect, CGFloat cornerRadius) {
    
    // create a mutable path
    CGMutablePathRef path = CGPathCreateMutable();
    
    // get the 4 corners of the rect
    CGPoint topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    
    // move to top left
    CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
    // add top line
    CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
    // add top right curve
    CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
    // add right line
    CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
    // add bottom right curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
    // add bottom line
    CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
    // add bottom left curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
    // add left line
    CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
    // add top left curve
    CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
    // return the path
    return path;
}


@implementation UIImage (utils)

- (UIImage *)fq_imageToSize:(CGSize) size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSData *)fq_JPEGRepresentationWithCompressionSize:(long long )size {
    //JEPG格式
    NSData *data = UIImageJPEGRepresentation(self, 1);
    NSUInteger length = data.length;
    if (length > size) {
        CGFloat compressionQuality = size*1.0/length;
        data = UIImageJPEGRepresentation(self, compressionQuality);
    }
    return data;
}

- (UIImage*)fq_grayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)fq_imageWithRenderingOriginal
{
    if ([self respondsToSelector:@selector(imageWithRenderingMode:)]) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (UIImage *)fq_imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius + 0.5, cornerRadius + 0.5, cornerRadius, cornerRadius)];
}

- (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius {
    return [self fq_imageWithBorderColor:color borderWidth:1 cornerRadius:cornerRadius];
}

- (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                      borderWidth:(CGFloat)borderWidth
                     cornerRadius:(CGFloat)cornerRadius {
    
    CGFloat newWidth = self.size.width + borderWidth*2;
    CGFloat newHeight = self.size.height + borderWidth*2;
    CGRect rect = CGRectMake(0, 0, newWidth, newHeight);
    CGRect imageRect = CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0.f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    [color setStroke];
    
    CGRect insetRect = CGRectInset(rect, borderWidth/2.0f, borderWidth/2.0f);
    
    CGMutablePathRef clipPath = fq_createRoundedCornerPath(rect, cornerRadius);
    // clip path to the context
    CGContextAddPath(ctx, clipPath);
    CGContextClip(ctx);
    
    [self drawInRect:imageRect];
    
    CGMutablePathRef path = fq_createRoundedCornerPath(insetRect, cornerRadius);
    CGContextAddPath(ctx, path);
    
    // set the stroke params
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx, borderWidth);
    
    // draw the path
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // release the path
    CGPathRelease(clipPath);
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(ctx);
    
    UIGraphicsEndImageContext();
    
    if (cornerRadius == 0)
    {
        return [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)];
    }
    
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius {
    return [UIImage fq_imageWithBorderColor:color innerColor:[UIColor clearColor] cornerRadius:cornerRadius];
}

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)borderColor innerColor:(UIColor *)innerColor cornerRadius:(CGFloat)cornerRadius {
    return [self fq_imageWithBorderColor:borderColor borderWidth:1 innerColor:innerColor cornerRadius:cornerRadius];
}

+ (UIImage *)fq_imageWithBorderColor:(UIColor *)borderColor
                      borderWidth:(CGFloat)borderWidth
                       innerColor:(UIColor *)innerColor
                     cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    minEdgeSize += 2;
    return [[UIImage fq_imageWithColor:innerColor size:CGSizeMake(minEdgeSize, minEdgeSize)] fq_imageWithBorderColor:borderColor cornerRadius:cornerRadius];
}

+ (UIImage *)fq_imageWithView:(UIView*)aView {
    CGRect rect = aView.bounds;
    //支持retina高分的关键
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:context];
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)fq_roundedRectangleImage:(CGSize)imageSize
                             color:(UIColor *)color
                       borderColor:(UIColor *)borderColor
                       borderWidth:(CGFloat)borderWidth
                      cornerRadius:(CGFloat)cornerRadius {
    CGRect rtFrame = CGRectZero;
    rtFrame.size = imageSize;
    UIImageView *roundedRectangleView = [[UIImageView alloc] initWithFrame:rtFrame];
    roundedRectangleView.layer.cornerRadius = cornerRadius;
    roundedRectangleView.layer.masksToBounds = YES;
    roundedRectangleView.layer.borderWidth = borderWidth;
    roundedRectangleView.layer.borderColor = [borderColor CGColor];
    roundedRectangleView.layer.backgroundColor = [color CGColor];
    
    UIImage *returnImage = [UIImage fq_imageWithView:roundedRectangleView];
    return returnImage;
}



- (UIImage *)fq_imageByApplyingAlpha:(CGFloat)alpha {
    if (alpha < 0.0f || alpha > 1.0f) {
        alpha = 0.5f;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return returnImage;
}

- (UIImage*)fq_highlightImage {
    const CGSize  size = self.size;
    const CGRect  bnds = CGRectMake(0.0, 0.0, size.width, size.height);
    UIColor*      colr = nil;
    UIImage*      copy = nil;
    CGContextRef  ctxt = NULL;
    
    // this is the mask color
    colr = [[UIColor alloc] initWithWhite:0 alpha:0.46];
    
    // begin image context
    
    UIGraphicsBeginImageContextWithOptions(bnds.size, FALSE, self.scale);
    
    ctxt = UIGraphicsGetCurrentContext();
    
    // transform CG* coords to UI* coords
    CGContextTranslateCTM(ctxt, 0.0, bnds.size.height);
    CGContextScaleCTM(ctxt, 1.0, -1.0);
    
    // draw original image
    CGContextDrawImage(ctxt, bnds, self.CGImage);
    
    // draw highlight overlay
    CGContextClipToMask(ctxt, bnds, self.CGImage);
    CGContextSetFillColorWithColor(ctxt, colr.CGColor);
    CGContextFillRect(ctxt, bnds);
    
    // finish image context
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}


+ (UIImage *)fq_imageWithColor:(UIColor *)color size:(CGSize)imgSize{
    CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _img;
}

- (UIImage *)fq_imageWithTintColor:(UIColor *)tintColor
{
    return [self fq_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)fq_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self fq_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)fq_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


//加模糊效果，image是图片，blur是模糊度
- (UIImage *)fq_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (image && !image.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", image);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = 10 > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(blur - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = 30 * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(22 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = blur;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (image) {
            CGContextClipToMask(outputContext, imageRect, image.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1.0 alpha:0.3].CGColor);
    CGContextFillRect(outputContext, imageRect);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (UIImage *)fq_imageFromView:(UIView *)orgView{
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)fq_imageFromAttributtedText:(NSAttributedString *)aAtt size:(CGSize)size
{
    NSAssert(size.width>0&&size.height>0, @"imageFromAttributtedText 申请的图片size为0");
    size = CGSizeMake(size.width*2, size.height*2);
    UIGraphicsBeginImageContext(size);
    [aAtt drawInRect:CGRectMake((size.width-aAtt.size.width)/2.0f, (size.height-aAtt.size.height)/2.0f, aAtt.size.width, aAtt.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:image.imageOrientation];
    
    return [image fq_imageWithRenderingOriginal];
}

- (UIImage *)fq_imageWithTextMask:(NSAttributedString *)attributedText {
    CGSize size= CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO , 0.0);
    [self drawAtPoint:CGPointMake(0, 0)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGSize textSize = [attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [attributedText drawAtPoint:CGPointMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight){
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (UIImage*)fq_roundedRectImageWithSize:(CGSize)size radius:(int)radius {
    size = CGSizeMake(size.width*2, size.height*2);
    radius = radius*2;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 4 * size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    return img;
}

@end
