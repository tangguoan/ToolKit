//
//  FQTextfield.m
//  Pods
//
//  Created by 唐--逍遥 on 16/7/9.
//
//

#import "FQTextField.h"

@implementation FQTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGFloat x = (15);
    if (self.leftView){
        x = self.leftView.frame.size.width + self.leftView.frame.origin.x;
    }
    return CGRectMake(bounds.origin.x + x, bounds.origin.y + 6, bounds.size.width - x, bounds.size.height - 2*6);
}

// text position
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat x = (15);
    if (self.leftView){
        x = self.leftView.frame.size.width + self.leftView.frame.origin.x;
    }
    return CGRectMake(bounds.origin.x + x, bounds.origin.y + 6, bounds.size.width -20- x, bounds.size.height - 2*6);
}

// text position while editing
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGFloat x = (15);
    if (self.leftView){
        x = self.leftView.frame.size.width + self.leftView.frame.origin.x;
    }
    return CGRectMake(bounds.origin.x + x, bounds.origin.y + 6, bounds.size.width - x-20, bounds.size.height - 2*6);
}
@end
