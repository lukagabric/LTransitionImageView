#import "ViewController.h"


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _transitionImageView = [[LTransitionImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
    [self.view addSubview:_transitionImageView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.image = [UIImage imageNamed:@"image0.jpg"];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionLeftToRight;
        _transitionImageView.image = [UIImage imageNamed:@"image1.jpg"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
        _transitionImageView.image = [UIImage imageNamed:@"image2.jpg"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionRightToLeft;
        _transitionImageView.image = [UIImage imageNamed:@"image3.jpg"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionBottomToTop;
        _transitionImageView.image = [UIImage imageNamed:@"image4.jpg"];
    });
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


@end