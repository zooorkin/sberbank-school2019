//
//  Kitchen.h
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KitchenDelegate.h"

/**
 Кухня
 */
@interface Kitchen : NSObject

@property (nonatomic, weak) id <KitchenDelegate> delegate;

-(Kitchen *)init;

/**
 Приготовить заказ
 */
-(void)cook;

@end
