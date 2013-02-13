#import "ViewController.h"


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _transitionImageView = [[LTransitionImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
    _transitionImageView.animationDuration = 3;
    [self.view addSubview:_transitionImageView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [self startAnimations];
    });
}


- (void)startAnimations
{
    CGFloat delay = _transitionImageView.animationDuration + 1;
    
    _transitionImageView.animationDirection = AnimationDirectionLeftToRight;
    _transitionImageView.image = [UIImage imageNamed:@"image0.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
        _transitionImageView.image = [UIImage imageNamed:@"image1.jpg"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
            _transitionImageView.animationDirection = AnimationDirectionRightToLeft;
            _transitionImageView.image = [UIImage imageNamed:@"image2.jpg"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                _transitionImageView.animationDirection = AnimationDirectionBottomToTop;
                _transitionImageView.image = [UIImage imageNamed:@"image3.jpg"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                    [self startAnimations];
                });
            });
        });
    });
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


@end