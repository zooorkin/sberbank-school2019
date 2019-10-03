//
//  main.m
//  HomeworkDelegate
//
//  Created by Андрей Зорькин on 02/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Visitor/Visitor.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Visitor *visitor = [[Visitor alloc] init];
        [visitor makeAnOrder];
    }
    return 0;
}
