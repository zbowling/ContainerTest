//
//  TestChildViewController.m
//  ContainerTest
//
//  Created by Zac Bowling on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestChildViewController.h"

UIColor* randomColor(int);

static int contCount = 0;

UIColor* randomColor(int offset) {
    static NSArray *colors;
    if (!colors) colors = [NSArray arrayWithObjects:[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor grayColor],[UIColor brownColor],[UIColor redColor], nil];
    UIColor *color = [colors objectAtIndex:offset % [colors count]]; //(arc4random() % [colors count])
    return color;
}

@implementation TestChildViewController {
    UILabel *_label;
    NSString *_labelText;
    UIColor *_backColor;
    int _rotationSupport;
}

@dynamic labelText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _labelText = [[NSDate date] description];
        _backColor = randomColor(contCount);
        _rotationSupport = arc4random() % 4;
        _labelText = [NSString stringWithFormat:@"View %i",contCount++]; 
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

- (NSString *)labelText {
    return _labelText;
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = [labelText copy];
    if ([self isViewLoaded])
       _label.text = [NSString stringWithFormat:@"(Test child controller.) \r\n%@",_labelText];
}




// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    //self.view.layer.shadowOffset = CGSizeMake(10, 10);
    //self.view.layer.shadowOpacity = 0.6;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    

    
    if (!_label)
        _label = [[UILabel alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10)];
    else
        _label.frame = CGRectInset(self.view.bounds, 10, 10);
    
    _label.text = [NSString stringWithFormat:@"(Test child controller.) \r\n%@",_labelText];
    _label.lineBreakMode = UILineBreakModeWordWrap;
    _label.textAlignment = UITextAlignmentCenter;
    
    //[self setLabelText:_labelText];
    _label.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _label.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = _backColor;
    //self.view = _label;
    [self.view addSubview:_label];

}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    _label = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Controller %@ \t viewWillAppear: %@",_labelText, animated?@"YES":@"NO");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Controller %@ \t viewDidAppear: %@",_labelText, animated?@"YES":@"NO");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"Controller %@ \t viewWillDisappear: %@",_labelText, animated?@"YES":@"NO");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"Controller %@ \t viewDidDisappear: %@",_labelText, animated?@"YES":@"NO");
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"Controller %@ \t viewDidLayoutSubviews",_labelText);
    //NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"Controller %@ \t viewWillLayoutSubviews",_labelText);
    //NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    NSLog(@"Controller %@ \t willMoveToParentViewController: %@",_labelText, parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    NSLog(@"Controller %@ \t didMoveToParentViewController: %@ ",_labelText, parent);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    switch (_rotationSupport) {
        case 0:
            if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
                return YES;
            break;
        case 1:
                return YES;
            break;
        case 2:
            if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
                return YES;
            break;
        case 3: 
            if (UIInterfaceOrientationLandscapeLeft == interfaceOrientation)
                return YES;
            break;
        default:
            break;
    }
    // Return YES for supported orientations
	return NO;
}

@end
