#import "LTransitionImageView.h"


#define UIColorFromHexAlpha(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]


@implementation LTransitionImageView


#pragma mark - Synthesize


@synthesize image = _image;
@synthesize animationDirection = _animationDirection;
@synthesize animationDuration = _animationDuration;


#pragma mark - Init


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (void)initializePrivate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initialize];
    });
}


- (void)initialize
{
    _animationDuration = 2;
    
    [self loadGUI];
    [self bindGUI];
    [self layoutGUI];
}


#pragma mark - loadGUI


- (void)loadGUI
{
    self.backgroundColor = [UIColor clearColor];
    
    [self loadImageLayers];
}


- (void)loadImageLayers
{
    _imageGroupLayer = [CALayer layer];
    
    _fromImageLayer = [CALayer layer];
    [_imageGroupLayer addSublayer:_fromImageLayer];
    
    _imageLayer = [CALayer layer];
    [_imageGroupLayer addSublayer:_imageLayer];
    
    _maskLayer = [CAGradientLayer layer];
    
    switch (_animationDirection)
    {
        case AnimationDirectionLeftToRight:
            _maskLayer.startPoint = CGPointMake(0, 0.5);
            _maskLayer.endPoint = CGPointMake(1, 0.5);
            break;
        case AnimationDirectionRightToLeft:
            _maskLayer.startPoint = CGPointMake(1, 0.5);
            _maskLayer.endPoint = CGPointMake(0, 0.5);
            break;
        case AnimationDirectionTopToBottom:
            _maskLayer.startPoint = CGPointMake(0.5, 0);
            _maskLayer.endPoint = CGPointMake(0.5, 1);
            break;
        case AnimationDirectionBottomToTop:
            _maskLayer.startPoint = CGPointMake(0.5, 1);
            _maskLayer.endPoint = CGPointMake(0.5, 0);
            break;
    }
    
    [_imageLayer setMask:_maskLayer];
    
    [self.layer addSublayer:_imageGroupLayer];
}


#pragma mark - bindGUI


- (void)bindGUI
{
    [self bindFromImage];
    [self bindImage];
    [self bindMaskLayer];
}


- (void)bindFromImage
{
    if (_fromImage)
        _fromImageLayer.contents = (__bridge id)_fromImage.CGImage;
}


- (void)bindImage
{
    if (_image)
        _imageLayer.contents = (__bridge id)_image.CGImage;
}


- (void)bindMaskLayer
{
    _maskLayer.colors = [self getGradientColors];
}


#pragma mark - layoutGUI


- (void)layoutGUI
{
    _imageGroupLayer.frame = self.bounds;
    _fromImageLayer.frame = self.bounds;
    _imageLayer.frame = self.bounds;
    
    switch (_animationDirection)
    {
        case AnimationDirectionLeftToRight:
            _maskLayer.frame = CGRectMake(-2*self.frame.size.width, 0, 2*self.frame.size.width, self.frame.size.height);
            break;
        case AnimationDirectionRightToLeft:
            _maskLayer.frame = CGRectMake(self.frame.size.width, 0, 2*self.frame.size.width, self.frame.size.height);
            break;
        case AnimationDirectionTopToBottom:
            _maskLayer.frame = CGRectMake(0, -2*self.frame.size.height, self.frame.size.width, 2*self.frame.size.height);
            break;
        case AnimationDirectionBottomToTop:
            _maskLayer.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 2*self.frame.size.height);
            break;
    }
}


#pragma mark - Setters


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutGUI];
}


- (void)setImage:(UIImage *)image
{
    [self clear];
    
    if (image)
    {
        [self loadImageLayers];
        
        if (_image)
        {
            _fromImage = [[UIImage alloc] initWithCGImage:_image.CGImage];
            _image = image;
            
            [self bindFromImage];
            [self bindImage];
            [self bindMaskLayer];
            [self layoutGUI];
            
            [self startAnimation];
        }
        else
        {
            _image = image;
            
            [self showImageOnly];
        }
    }
}


- (void)showImageOnly
{
    [self freeMaskLayer];
    [self freeFromImageLayer];
    [self bindGUI];
    [self layoutGUI];
}


#pragma mark - Getters


- (NSArray *)getGradientColors
{
    return [NSArray arrayWithObjects:
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.99) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.95) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.9) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.8) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.7) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.6) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.5) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.4) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.3) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.2) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.1) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.05) CGColor],
            (id)[UIColorFromHexAlpha(0xffffff, 0.01) CGColor],
            nil];
}


#pragma mark - Animation


- (void)startAnimation
{
    CGPoint currentPosition = [[_maskLayer valueForKey:@"position"] CGPointValue];
    
    CGPoint newPosition;
    
    switch (_animationDirection)
    {
        case AnimationDirectionLeftToRight:
            newPosition = CGPointMake(currentPosition.x + _maskLayer.frame.size.width, currentPosition.y);
            break;
        case AnimationDirectionRightToLeft:
            newPosition = CGPointMake(currentPosition.x - _maskLayer.frame.size.width, currentPosition.y);
            break;
        case AnimationDirectionTopToBottom:
            newPosition = CGPointMake(currentPosition.x, currentPosition.y + _maskLayer.frame.size.height);
            break;
        case AnimationDirectionBottomToTop:
            newPosition = CGPointMake(currentPosition.x, currentPosition.y - _maskLayer.frame.size.height);
            break;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.fromValue = [_maskLayer valueForKey:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:newPosition];
    animation.duration = _animationDuration;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animation setValue:@"position" forKey:@"animationType"];
    
    _maskLayer.position = newPosition;
    
    [_maskLayer addAnimation:animation forKey:@"position"];
}


#pragma mark Delegate


- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
    NSString *value = [animation valueForKey:@"animationType"];
    if ([value isEqualToString:@"position"])
    {
        [self showImageOnly];
    }
}


#pragma mark Clear


- (void)freeMaskLayer
{
    [_maskLayer removeAllAnimations];
    [_maskLayer removeFromSuperlayer];
    _maskLayer = nil;
}


- (void)freeImageLayer
{
    [_imageLayer removeFromSuperlayer];
    _imageLayer = nil;
}


- (void)freeFromImageLayer
{
    [_fromImageLayer removeFromSuperlayer];
    _fromImageLayer = nil;
}


- (void)freeComboLayer
{
    [_imageGroupLayer removeFromSuperlayer];
    _imageGroupLayer = nil;
}


- (void)clear
{
    [self freeMaskLayer];
    [self freeImageLayer];
    [self freeFromImageLayer];
    [self freeComboLayer];
}


#pragma mark -


@end