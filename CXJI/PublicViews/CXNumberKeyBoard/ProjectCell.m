//
//  ProjectCell.m
//  CXJI
//
//  Created by fizz on 16/11/1.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "ProjectCell.h"

@implementation ProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        
        self = [nibs firstObject];
        
    }
    return self;
}

@end
