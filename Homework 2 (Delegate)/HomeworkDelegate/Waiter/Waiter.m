//
//  Waiter.m
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import "Waiter.h"
#import "Kitchen.h"

@interface Waiter () <KitchenDelegate>

@property (nonatomic, strong) Kitchen *kitchen;

@end


@implementation Waiter

-(instancetype)init
{
    self = [super init];
    {
        self.kitchen = [[Kitchen alloc] init];
        self.kitchen.delegate = self;
    }
    return self;
}

-(void)order
{
    NSLog(@"Официант относит заказ на кухню");
    [self.kitchen cook];
}

-(void)thankAndTip
{
    
}

- (void)kitchedDidFinishCook
{
    NSLog(@"Официант приносит заказ гостю");
    [self.delegate waiterDidGetOrder];
}

@end
