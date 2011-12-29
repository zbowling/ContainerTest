//
//  ContainerViewController.m
//  ContainerTest
//
//  Created by Zac Bowling on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContainerViewController.h"
#import "TestChildViewController.h"

@implementation ContainerViewController {
    UIViewController *_bottomViewController;
    NSMutableArray *_topViewControllers;
    NSUInteger _topControllerIndex;
}

@synthesize bottomViewController=_bottomViewController;

- (id) initWithTopBaseViewController:(UIViewController *)viewController bottomViewController:(UIViewController *)bottomViewController;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _bottomViewController = bottomViewController;
        _topViewControllers = [NSMutableArray arrayWithObject:viewController];
        
        [self addChildViewController:bottomViewController];
        [self addChildViewController:viewController];
        
        _topControllerIndex = 0;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(newItem:)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(removeItem:)];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)attachCurrentViewControllers {
    [self view];
    
    [_bottomViewController willMoveToParentViewController:self];


    _bottomViewController.view.frame = self.containerView.bottomView.bounds;
    _bottomViewController.view.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [_bottomViewController didMoveToParentViewController:self];
    
    [self.containerView.bottomView addSubview:_bottomViewController.view];
    
    
    //setup top view controller
    UIViewController *topViewController = (UIViewController *)[_topViewControllers objectAtIndex:_topControllerIndex];
    
    [topViewController willMoveToParentViewController:self];
    for (UIView *view in [self.containerView.topView subviews])
    {
        [view removeFromSuperview];
    }
    
    UIView *mview = topViewController.view;
    mview.frame = self.containerView.topView.bounds;
    mview.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.containerView.topView addSubview:mview];
    [topViewController didMoveToParentViewController:self];
}

- (ContainerView *)containerView {
    return (ContainerView *)self.view;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[ContainerView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

}

/*- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"Controller viewDidLayoutSubviews: %@",self);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"Controller viewWillLayoutSubviews: %@",self);
}
*/




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self attachCurrentViewControllers];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)pushTopViewController:(UIViewController *)newViewController {
     UIViewController *top = (UIViewController *)[_topViewControllers objectAtIndex:_topControllerIndex];
    
    _topControllerIndex++;
    
    [_topViewControllers addObject:newViewController];
    
    [self addChildViewController:newViewController];
    
    UIView *mview = newViewController.view;
        
    //NSLog(@"%@",NSStringFromCGRect(mview.frame));
    
    CGRect destinationRect = top.view.frame;
    CGRect startRect = destinationRect;
    
    startRect.origin.x += self.containerView.bounds.size.width;
    startRect.size.width /=2.0;
    startRect.size.height /=2.0;
    mview.frame = startRect; 
    mview.alpha = 0.0f;
    NSLog(@"transitionFromViewController");
    //[UIViewController attemptRotationToDeviceOrientation];
    [self transitionFromViewController:top toViewController:newViewController duration:0.3f options: UIViewAnimationOptionCurveEaseIn
                                animations:^{ 
                                    [self.containerView.topView addSubview:mview];
                                    mview.alpha = 1.0f;
                                    mview.frame = destinationRect;
                                    //[self attachTopViewControllerView:newViewController];
                                } 
                                completion:^(BOOL finished){
                                    [top.view removeFromSuperview];
                                    [self.containerView.topView addSubview:mview];
                                    mview.frame = self.containerView.topView.bounds;
                                    mview.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                                    [newViewController didMoveToParentViewController:self];
                                }];
}

- (void)popTopViewController {
    if (_topControllerIndex >0)
    {
        
        UIViewController *next = (UIViewController *)[_topViewControllers objectAtIndex:_topControllerIndex-1];
        
        UIViewController *current = (UIViewController *)[_topViewControllers objectAtIndex:_topControllerIndex];
        
        _topControllerIndex--;
        
        [current willMoveToParentViewController:nil];
        
        [_topViewControllers removeObject:current];
        
        next.view.frame = self.containerView.topView.bounds;
        
        
        [self transitionFromViewController:current toViewController:next duration:1
                                   options:UIViewAnimationOptionTransitionCurlDown
                                animations:^{ 
                                    [self.containerView.topView addSubview:next.view];
                                    //next.view.frame = self.containerView.topView.bounds;
                                } 
                                completion:^(BOOL finished){
                                    
                                    [current.view removeFromSuperview];
                                    [next didMoveToParentViewController:self];
                                    [current removeFromParentViewController];

                                    //Call to test if the new top controller wants us to rotate
                                    [UIViewController attemptRotationToDeviceOrientation];
                                }];
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"shouldAutorotateToInterfaceOrientation called");
    // Return YES for supported orientations
    UIViewController *top = (UIViewController *)[_topViewControllers objectAtIndex:_topControllerIndex];
    
	return [top shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}


- (void)newItem:(id)sender {
    TestChildViewController *alpha = [[TestChildViewController alloc] initWithNibName:nil bundle:nil];
    [self pushTopViewController:alpha];
}

- (void)removeItem:(id)sender {
    [self popTopViewController];
}

@end
