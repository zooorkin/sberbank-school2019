//
//  ISSPresentView.m
//  TrelloTable
//
//  Created by Андрей Зорькин on 31/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import "ISSPresentView.h"

@interface ISSPresentView ()

@property (nonatomic, strong) UITextField *taskField;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation ISSPresentView


+ (ISSPresentView *)viewForTask
{
    ISSPresentView *presentView = [[ISSPresentView alloc] initWithFrame: CGRectMake(0, 0, 300, 300)];
    presentView.layer.cornerRadius = 16.0;
    presentView.layer.masksToBounds = YES;
    presentView.backgroundColor = [UIColor yellowColor];
    [presentView setupViews];
    return presentView;
    
}

- (void)setupViews
{
    UIEdgeInsets insets = UIEdgeInsetsMake(16, 16, 16, 16);
    self.taskField.frame = UIEdgeInsetsInsetRect(self.frame, insets);
    self.taskField.textAlignment = NSTextAlignmentLeft;
    [self.taskField setPlaceholder:@"Введите текст"];
    [self addSubview:self.taskField];
    
    self.doneButton.frame = CGRectMake(300 - 64 - 16, 300 - 32 - 16, 64, 32);
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.doneButton];
}

- (void)doneTapped
{
    NSString *text = self.taskField.text;
    self.done(text);
    [self close];
    
}

- (void)didMoveToSuperview
{
    self.center = CGPointMake(self.superview.center.x, [UIScreen mainScreen].bounds.size.height * 1.5);
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(self.superview.center.x, [UIScreen mainScreen].bounds.size.height / 2);
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(self.superview.center.x, -[UIScreen mainScreen].bounds.size.height / 2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
   
}

- (UITextField *)taskField
{
    if (_taskField)
    {
        return _taskField;
    }
    _taskField = [[UITextField alloc] init];
    return _taskField;
}

- (UIButton *)doneButton
{
    if (_doneButton)
    {
        return _doneButton;
    }
    _doneButton = [[UIButton alloc] init];
    return _doneButton;
}

@end
