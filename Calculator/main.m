//
//  main.m
//  Calculator
//
//  Created by Keith Lee on 1/4/13.
//  Copyright (c) 2013 Keith Lee. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//   1. Redistributions of source code must retain the above copyright notice, this list of
//      conditions and the following disclaimer.
//
//   2. Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY Keith Lee ''AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Keith Lee OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Keith Lee.

#import <Foundation/Foundation.h>
#import "Calculator.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool
  {
    Calculator *calc = [[Calculator alloc] init];
    NSNumber *addend1 = [NSNumber numberWithInteger:-25];
    NSNumber *addend2 = [NSNumber numberWithInteger:10];
    NSNumber *addend3 = [NSNumber numberWithInteger:15];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL selector1 = @selector(sumAddend1:addend2:);
    id sum1 = [calc performSelector:selector1 withObject:addend1
               withObject:addend2];
    NSLog(@"Sum of %@ + %@ = %@", addend1, addend2, sum1);
    
    SEL selector2 = NSSelectorFromString(@"sumAddend1::");
    id sum2 = [calc performSelector:selector2 withObject:addend1
               withObject:addend3];
    NSLog(@"Sum of %@ + %@ = %@", addend1, addend3, sum2);
    
    SEL selector3 = NSSelectorFromString(@"absoluteValue:");
    NSLog(@"Invoking instance method %@ on object of class %@",
          NSStringFromSelector(selector3), [calc className]);
    id sum3 = [calc performSelector:selector3 withObject:sum2];
    NSLog(@"Absolute value of %@ = %@", sum2, sum3);
#pragma clang diagnostic pop
    
    NSBundle *bundle = [NSBundle bundleWithPath:
              @"/Users/klee/Documents/Publishing/Apress/ProObjectiveC/dev/Test/build/Release/Test.bundle"];
    if (bundle == nil)
    {
      NSLog(@"Bundle not found at path");
    }
    else
    {
      NSError *error = [[NSError alloc] init];
      BOOL isLoaded = [bundle loadAndReturnError:&error];
      NSLog(@"Bundle is loaded = %d", isLoaded);
      if (!isLoaded)
      {
        NSLog(@"Error = %@", [error localizedDescription]);
      }
      else
      {
        Class principalClass = [bundle principalClass];
        id tester = [[principalClass alloc] init];
        [tester performSelector:@selector(hello)];
      }
    }

  }
  return 0;
}

