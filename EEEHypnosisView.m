//
//  EEEHypnosisView.m
//  Hypnosister
//
//  Created by Andrew Vasquez on 11/29/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import "EEEHypnosisView.h"

@interface EEEHypnosisView ()

@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation EEEHypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect myBounds = self.bounds;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    
    //About to apply a triangle clipping path to the gradient
    CGContextSaveGState(currentContext);
    
    CGPoint topPoint = CGPointMake(myBounds.size.width/2.0, myBounds.size.height/6.0);
    CGPoint rightPoint = CGPointMake(myBounds.size.width*(3.0/4.0), myBounds.size.height*(5.0/6.0));
    CGPoint leftPoint = CGPointMake(myBounds.size.width/4.0, myBounds.size.height*(5.0/6.0));
    
    UIBezierPath *triClipping = [[UIBezierPath alloc] init];
    [triClipping moveToPoint:topPoint];
    [triClipping addLineToPoint:rightPoint];
    [triClipping addLineToPoint:leftPoint];
    [triClipping addLineToPoint:topPoint];
    
    [triClipping addClip];
    
    CGFloat locations[2] = {0.0,1.0};
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0,  //Start color is red
        1.0, 1.0, 0.0, 1.0}; //End color is yellow
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(myBounds.origin.x, myBounds.origin.y);
    CGPoint endPoint = CGPointMake(myBounds.size.width, myBounds.size.height);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //End adding a triangle clipping to the gradient
    CGContextRestoreGState(currentContext);
    
    
    // About to apply Shadow affect for image and path defined
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    
    //Set properties for path
    
    CGPoint circleCenter = CGPointMake(myBounds.size.width/2,
                                       myBounds.size.height/2);
    
    CGFloat radius = hypot(myBounds.size.width, myBounds.size.height)/2.0;
    
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    
    //Update radius
    for(;radius>0;radius-=20){
        [circlePath moveToPoint:CGPointMake(circleCenter.x + radius, circleCenter.y)];
        [circlePath addArcWithCenter:circleCenter radius:radius startAngle:0.0 endAngle:M_PI*2.0 clockwise:YES];
    }
    
    //Modify path properties
    circlePath.lineWidth = 10.0;
    [self.circleColor setStroke];

    [circlePath stroke];
    
    //Add Image
    UIImage *logo = [UIImage imageNamed:@"soundRobinLogo.png"];
    [logo drawInRect:rect];
    
    //End adding shadow to objects placed in context
    CGContextRestoreGState(currentContext);
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@ was touched", self);
    
    CGFloat red = (arc4random() % 100)/100.0;
    CGFloat green = (arc4random() % 100)/100.0;
    CGFloat blue = (arc4random() % 100)/100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor = randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor{
    
    _circleColor = circleColor;
    [self setNeedsDisplay];
}
@end
