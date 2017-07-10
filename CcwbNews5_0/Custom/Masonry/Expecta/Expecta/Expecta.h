#import <Foundation/Foundation.h>

//! Project version number for Expecta.
FOUNDATION_EXPORT double ExpectaVersionNumber;

//! Project version string for Expecta.
FOUNDATION_EXPORT const unsigned char ExpectaVersionString[];

#import "ExpectaObject.h"
#import "ExpectaSupport.h"
#import "EXPMatchers.h"

// Enable shorthand by default
#define expect(...) EXP_expect((__VA_ARGS__))
#define failure(...) EXP_failure((__VA_ARGS__))
