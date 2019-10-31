//
//  ISSPresentView.h
//  TrelloTable
//
//  Created by Андрей Зорькин on 31/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View для добавления новой карточки
@interface ISSPresentView : UIView

/// Completion-блок, который будет вызван после добавления карточки
@property (nonatomic, strong) void (^done)(NSString *);

/// Получить экземпляр ISSPresentView
+ (ISSPresentView *)viewForTask;

@end

NS_ASSUME_NONNULL_END
