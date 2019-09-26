//
//  main.m
//  Homework1
//
//  Created by Андрей Зорькин on 26/09/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Функция, выводящее содержимое массива

 @param array массив
 */
void printArray(const NSString *exercise, const NSMutableArray *array)
{
    NSLog(@"\t%@ [%@]", exercise, [array componentsJoinedByString: @" "]);
}

int main()
{
    @autoreleasepool
    {
        //  1.
        NSMutableArray * array = @[@(3), @(6), @(32), @(24), @(81)].mutableCopy;
        printArray(@"1.  ", array);
        
        //  1.1
        [array sortUsingSelector: @selector(compare:)];
        printArray(@"1.1.", array);
        
        //  1.2
        NSMutableArray * arrayWithGreaterThan20 = [NSMutableArray array];
        for (NSNumber *number in array)
            if ([number isKindOfClass: [NSNumber class]])
                if ([(NSNumber *) number integerValue] > 20)
                    [arrayWithGreaterThan20 addObject:number];
        printArray(@"1.2.", arrayWithGreaterThan20);
        
        //  1.3
        NSMutableArray * arrayWithDivisible3 = [NSMutableArray array];
        for (NSNumber *number in array)
            if ([number isKindOfClass: [NSNumber class]])
                if ([(NSNumber *) number integerValue] % 3 == 0)
                    [arrayWithDivisible3 addObject:number];
        printArray(@"1.3.", arrayWithDivisible3);
        
        //  1.4
        [array addObjectsFromArray:arrayWithDivisible3];
        printArray(@"1.4.", array);
        
        //  1.5
        [array sortUsingComparator: ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [(NSNumber *)obj1 integerValue ] < [(NSNumber *)obj2 integerValue];
        }];
        printArray(@"1.5.", array);
        
        NSLog(@"");
        
        //  2
        NSMutableArray *words = @[@"cataclism", @"catepillar",
                                   @"cat", @"teapot", @"truncate"].mutableCopy;
        printArray(@"2.  ", words);
        
        //  2.1
        NSPredicate *predicateHasCat = [NSPredicate predicateWithBlock: ^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [(NSString *)evaluatedObject hasPrefix: @"cat"];
        }];
        [words filterUsingPredicate: predicateHasCat];
        
        //  2.2
        printArray(@"2.2.", words);
        
        //  2.3
        NSMutableDictionary *numberOfLetters = [NSMutableDictionary dictionary];
        for (NSString *word in words)
            numberOfLetters[word] = @([word length]);
        
        for (NSString *word in numberOfLetters.allKeys)
            NSLog(@"\t2.3. Слово %@ состоит из %@ букв", word, numberOfLetters[word]);
        
    }
}
