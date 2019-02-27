//
//  PresentViewController.m
//  AnimationDemo
//
//  Created by 蒋伟 on 2019/2/26.
//  Copyright © 2019 中国人寿. All rights reserved.
//

#import "PresentViewController.h"
#import "JWAnimators.h"

@interface PresentViewController ()

@end

@implementation PresentViewController {
    
    JWAnimators *_circleAnimator;
    
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        _circleAnimator = [[JWAnimators alloc] init];;
        self.transitioningDelegate = _circleAnimator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
