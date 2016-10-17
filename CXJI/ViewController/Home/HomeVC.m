//
//  HomeVC.m
//  CXJI
//
//  Created by fizz on 16/10/13.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)NewExpendAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self showAnimatonWithSeleted:M_PI_4*3];
    }else{
        [self showAnimatonWithSeleted:0];
    }
    

    
}

- (void)showAnimatonWithSeleted:(CGFloat)Rotataion
{
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnimation.toValue = @(Rotataion);
    rotationAnimation.springBounciness = 8;
    rotationAnimation.springSpeed = 3;
    rotationAnimation.dynamicsFriction = 12;
    [_addBtn.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
