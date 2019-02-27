//
//  ViewController.m
//  AnimationDemo
//
//  Created by 蒋伟 on 2019/2/26.
//  Copyright © 2019 中国人寿. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *redButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redButton.layer.cornerRadius = 25;
    self.redButton.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)presentAction:(id)sender {
    
    PresentViewController *vc = [[PresentViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
