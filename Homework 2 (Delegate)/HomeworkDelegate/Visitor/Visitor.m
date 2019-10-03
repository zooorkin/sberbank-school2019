//
//  Visitor.m
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import "Visitor.h"
#import "Waiter.h"

@interface Visitor () <WaiterDelegate>

@property (nonatomic, strong) Waiter *waiter;

@end


@implementation Visitor

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.waiter = [[Waiter alloc] init];
        self.waiter.delegate = self;
    }
    return self;
}

- (void)makeAnOrder
{
    NSLog(@"Гость делает заказ официанту");
    [self.waiter order];
}

- (void)waiterDidGetOrder
{
    NSLog(@"Гость благодарит и оставляет чаевые");
    [self.waiter thankAndTip];
}

@end
