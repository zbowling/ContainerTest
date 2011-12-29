//
//  ContainerView.m
//  ContainerTest
//
//  Created by Zac Bowling on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContainerView.h"

@implementation ContainerView {
    UIView *_bottomView;
    UIView *_topView;
}

@synthesize topView=_topView,bottomView=_bottomView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect bottom,top;
        CGRectDivide(self.bounds, &bottom, &top, 100, CGRectMaxYEdge);
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomView.frame = CGRectInset(bottom, 5, 5);
        _bottomView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        [self addSubview:_bottomView];
        
        
        _topView = [[UIView alloc]initWithFrame:CGRectZero];
        _topView.frame = CGRectInset(top, 5, 5);
        _topView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
        _topView.backgroundColor = [UIColor greenColor];
        [self addSubview:_topView];
        [self layoutIfNeeded];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
