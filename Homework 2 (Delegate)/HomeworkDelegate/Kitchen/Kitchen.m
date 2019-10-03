//
//  Kitchen.m
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import "Kitchen.h"

@implementation Kitchen

-(instancetype)init
{
    self = [super init];
    return self;
}

-(void)cook
{
    NSLog(@"Заказ готов");
    // Готовка...
    NSLog(@"Кухня передаёт заказ официанту");
    [self.delegate kitchedDidFinishCook];
}

@end
