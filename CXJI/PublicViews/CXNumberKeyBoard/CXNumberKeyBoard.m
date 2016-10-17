//
//  CXNumberKeyBoard.m
//  CXJI
//
//  Created by fizz on 16/10/17.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "CXNumberKeyBoard.h"

@implementation CXNumberKeyBoard


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        
        self = [nibs firstObject];
    }
    return self;
}

@end
