#import "NSString+RemoveEmoji.h"

@implementation NSString (RemoveEmoji)

- (BOOL)isEmoji {
    BOOL returnValue = NO;
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
        if (ls == 0xfe0f) {
            if (hs == 0x203c || hs == 0x2049 || hs == 0x231a || hs == 0x231b || hs == 0x24c2 ||
                hs == 0x2934 || hs == 0x2935 || hs == 0x303d || hs == 0x3297 || hs == 0x3299) {
                returnValue = YES;
            }else if (hs >= 0x2139 && hs <= 0x21aa){
                returnValue = YES;
            }else if (hs >= 0x25aa && hs <= 0x27a1 ){
                returnValue = YES;
            }else if (hs >= 0x2b05 && hs <= 0x2b55 ){
                returnValue = YES;
            }
        }
        
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    return returnValue;
}

- (BOOL)stringContainsEmoji{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
     }];
    
    return returnValue;
}

- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        if ([substring isEmoji]) {
            *stop = YES;
            result = YES;
        }
    }];
    
    return result;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        [buffer appendString:([substring isEmoji])? @"": substring];
    }];
    
    return buffer;
}

@end
