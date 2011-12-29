//
//  ContainerViewController.h
//  ContainerTest
//
//  Created by Zac Bowling on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerView.h"

UIColor* randomColor();

@interface ContainerViewController : UIViewController

- (id) initWithTopBaseViewController:(UIViewController *)viewController bottomViewController:(UIViewController *)bottomViewController;

@property (readonly,nonatomic) ContainerView *containerView;


@property (readonly,nonatomic) UIViewController *bottomViewController;
- (void)pushTopViewController:(UIViewController *)topViewController;
- (void)popTopViewController;



@end
