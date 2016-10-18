//
//  CXNumberKeyBoard.m
//  CXJI
//
//  Created by fizz on 16/10/17.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "CXNumberKeyBoard.h"

#define remainHeight 80

@interface CXNumberKeyBoard()

{
    UIWindow *window;
}

@property (weak, nonatomic) IBOutlet UIButton *zeroBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *sevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *eightBtn;
@property (weak, nonatomic) IBOutlet UIButton *nineBtn;
@property (weak, nonatomic) IBOutlet UIButton *pointBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *subtractBtn;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;

@end

@implementation CXNumberKeyBoard

/*
+ (CXNumberKeyBoard *)share
{
    static dispatch_once_t once = 0;
    static CXNumberKeyBoard *numberKey;
    
    dispatch_once(&once, ^{numberKey = [[CXNumberKeyBoard alloc]init];});
    
    return numberKey;
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        
        self = [nibs firstObject];
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-remainHeight);
        
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        
        if ([delegate respondsToSelector:@selector(window)])
            window = [delegate performSelector:@selector(window)];
        else {
            window = [[UIApplication sharedApplication] keyWindow];
        }
        
        [window addSubview:self];
    }
    return self;
}

- (void)show
{
    
    [self animation:(ScreenHeight-remainHeight)/2];
}

- (void)dissMiss
{
    [self animation:ScreenHeight+(ScreenHeight-remainHeight)/2];
}

- (IBAction)cancelAction:(id)sender {
    
    [self animation:(ScreenHeight-remainHeight)/2];
}

- (void)animation:(CGFloat )value
{
    POPSpringAnimation *pa = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    pa.toValue = @(value);  //中心点的值
    pa.springBounciness = 6;
    pa.springSpeed = 8;
    [self.layer pop_addAnimation:pa forKey:@"positionAnimation"];
}

@end
