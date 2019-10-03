//
//  Visitor.h
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 03/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Гость в ресторане
 */
@interface Visitor : NSObject

-(instancetype)init;

/**
 Сделать заказ
 */
-(void)makeAnOrder;

@end
