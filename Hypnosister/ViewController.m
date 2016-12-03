//
//  ViewController.m
//  Hypnosister
//
//  Created by Andrew Vasquez on 11/29/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import "ViewController.h"
#import "EEEHypnosisView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect rect = self.view.bounds;
    
    CGRect bigRect = CGRectMake(rect.origin.x,
                                rect.origin.y,
                                rect.size.width*2.0,
                                rect.size.height);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = bigRect.size;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    EEEHypnosisView *firstView = [[EEEHypnosisView alloc] initWithFrame:bigRect];
    
    [scrollView addSubview:firstView];
    
    
    CGRect nextBigRect = CGRectMake(rect.origin.x + rect.size.width*2.0,
                                    rect.origin.y,
                                    rect.size.width*2.0,
                                    rect.size.height);
    
    
    EEEHypnosisView *nextView = [[EEEHypnosisView alloc] initWithFrame:nextBigRect];
    
    [scrollView addSubview:nextView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
