LTransitionImageView
====================

iOS Image View with transition effect between images

Overview
--------
The LTransitionImageView class has only three properties you may want to set:

    @property (strong, nonatomic) UIImage *image;
    @property (assign, nonatomic) AnimationDirection animationDirection;
    @property (assign, nonatomic) CGFloat animationDuration;

- image – the content image
- animationDirection – one of the four supported transition animations
- animationDuration – defaults to 2 seconds if not set

The following transition effects are supported (animationDirection property):

- AnimationDirectionLeftToRight
- AnimationDirectionRightToLeft
- AnimationDirectionTopToBottom
- AnimationDirectionBottomToTop

Installation
------------
Just import the LTransitionImageView class files into your project.

Sample
------

    _transitionImageView.image = [UIImage imageNamed:@"image0.jpg"];
    _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
    _transitionImageView.image = [UIImage imageNamed:@"image1.jpg"];


For more information check the LTransitionImageViewSample.
