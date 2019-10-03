//
//  Waiter.h
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaiterDelegate.h"

/**
 Официант
 */
@interface Waiter : NSObject

@property (nonatomic, weak) id <WaiterDelegate> delegate;

-(instancetype)init;

/**
 Заказать
 */
-(void)order;


/**
 Поблагодарить официанта и оставить чаевые
 */
-(void)thankAndTip;

@end
