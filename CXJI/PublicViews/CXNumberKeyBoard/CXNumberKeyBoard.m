//
//  CXNumberKeyBoard.m
//  CXJI
//
//  Created by fizz on 16/10/17.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "CXNumberKeyBoard.h"
#import "ProjectCell.h"

#define remainHeight 80

@interface CXNumberKeyBoard()<UICollectionViewDelegate, UICollectionViewDataSource>

{
    UIWindow *window;
    BOOL isNum1;
    NSNumber *calculateTag;
}

@property (nonatomic, strong) NSMutableString *num1;
@property (nonatomic, strong) NSMutableString *num2;
@property (nonatomic, strong) NSMutableString *tempStr;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
        
        self.num1 = [[NSMutableString alloc]init];
        
        self.num2 = [[NSMutableString alloc]init];
        
        self.tempStr = [[NSMutableString alloc]init];

        isNum1 = YES;
        [self createCollerctionView];
        
        [window addSubview:self];
    }
    return self;
}

- (IBAction)clickAction:(UIButton *)sender {
    
   // 以0开头
    if ([self.tempStr hasPrefix:@"0"] && sender.tag >0 && sender.tag < 10 && [self.tempStr hasPrefix:@"0."]) {
        
        self.tempStr = [NSMutableString stringWithString:@""];
    }
    
    //如果是以0开头，但是不是以0.开头，则直接返回
    else if ([self.tempStr hasPrefix:@"0"] && [sender tag] == 0 && ![self.tempStr hasPrefix:@"0."]){
        return;
    }
    

    if ([sender tag] == 10 && self.tempStr.length == 0){
        
        self.tempStr = [NSMutableString stringWithString:@"0"];
    }
    
    if([sender tag] == 10 )
    {
        //小数点只允许输入一次, 遍历字符串tempStr，如果有小数点，则直接return
        for (int i = 0; i < self.tempStr.length ; i++){
            
            char c = [self.tempStr characterAtIndex:i];
            if (c == '.'){
                return;
            }
        }
        [self.tempStr appendString:@"."];
        
    }else{
        
        [self.tempStr appendFormat:@"%ld",[sender tag]];
    }

    self.resultLabel.text = self.tempStr;
}

- (IBAction)clearAction:(UIButton *)sender {
    
    self.tempStr = [NSMutableString stringWithString:@""];
    self.resultLabel.text = self.tempStr;
}

- (IBAction)calculate:(UIButton *)sender {
    
     self.tempStr = [NSMutableString stringWithString:@""];
    
    if (isNum1) {
       
        calculateTag = [NSNumber numberWithLong:[sender tag]];
        self.num1 = [NSMutableString stringWithFormat:@"%@",_resultLabel.text];
    }else{
        
        self.num2 = [NSMutableString stringWithFormat:@"%@",_resultLabel.text];
        
        int calculate = [calculateTag intValue];
        
        switch (calculate) {
                
            case 12:
                
                _resultLabel.text =[NSString stringWithFormat:@"%.2f",([self.num1 doubleValue] + [self.num2 intValue])];
                
                break;
                
            case 13:
                
                _resultLabel.text =[NSString stringWithFormat:@"%.2f",([self.num1 doubleValue] - [self.num2 intValue])];
                
                break;
        }
        
        self.num1 = [NSMutableString stringWithFormat:@"%@", _resultLabel.text];
        
        calculateTag = [NSNumber numberWithLong:[sender tag]];
        
    }
    
    isNum1 = NO;
}

- (void)createCollerctionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.collectionView registerClass:[ProjectCell class] forCellWithReuseIdentifier:@"CollectionCell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    cell.typeLabel.text = @"类别";
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.f;
}

- (void)show
{
    [self animation:(ScreenHeight-remainHeight)/2];
}

- (void)dissMiss
{
    [self clearAction:nil];
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
