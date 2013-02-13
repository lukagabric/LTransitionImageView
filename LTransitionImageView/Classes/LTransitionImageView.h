#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


typedef enum tagAnimationDirection
{
    AnimationDirectionLeftToRight,
    AnimationDirectionRightToLeft,
    AnimationDirectionTopToBottom,
    AnimationDirectionBottomToTop
}AnimationDirection;


@interface LTransitionImageView : UIView
{
    CAGradientLayer *_maskLayer;
    CALayer *_imageLayer;
    CALayer *_fromImageLayer;
    CALayer *_imageGroupLayer;
    
    UIImage *_image;
    UIImage *_fromImage;
    
    AnimationDirection _animationDirection;
    CGFloat _animationDuration;
}


@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) AnimationDirection animationDirection;
@property (assign, nonatomic) CGFloat animationDuration;


@end