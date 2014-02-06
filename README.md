NSObject_Ivar
=============

A category for NSObject that extracts all instance variables info and value


How to use
==========

Add the header to your files

```Objective-C
#import "NSObject+Ivar.h"
```


Call the method that suits you most from any subclass of the NSObject.
For example, this class

```Objective-C
@interface ObjectWithPrimitiveValues : NSObject
+ (instancetype)obj;
@end


@implementation ObjectWithPrimitiveValues {

    char                _aChar;
    BOOL                _aBool;
    short               _aShort;
    int                 _anInt;
    long                _aLong;
    long long           _aLongLong;

    unsigned int        _anUnsignedInt;
    unsigned char       _anUnsignedChar;
    unsigned long       _anUnsignedLong;
    unsigned long long _anUnsignedLongLong;
    unsigned short      _anUnsignedShort;

    double              _aDouble;
    float               _aFloat;

    char*               _aCharString;
    Class               _aClass;
    id                  _anObject;
    SEL                 _aSelector;
}


+ (instancetype)obj {

    return [[self alloc] init];
}


- (id)init
{
    self = [super init];
    if (self) {

        _aChar = 'a';
        _aBool = YES;
        _aShort = -35;
        _anInt = -32000;
        _aLong = -2000000;
        _aLongLong = -9000000;
        _anUnsignedInt = 60000;
        _anUnsignedChar = 254;
        _anUnsignedLong = 2000000;
        _anUnsignedLongLong = 9000000;

        _aDouble = 1234e-89;
        _aFloat = 67e34;

        _aCharString = "this is a message \n read it carefully and";
        _aClass = [NSString class];
        _anObject = self;
        _aSelector = @selector(initByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:);
    }
    return self;
}

@end
```

if sent the *ivarDescriptions* selector

```
NSLog(@"%@", [[ObjectWithPrimitiveValues obj] ivarDescriptions])
```

 will return


```Objective-C
ObjectWithPrimitiveValues {
    char _aChar = 97
    char _aBool = 1
    short _aShort = -35
    int _anInt = -32000
    long _aLong = -2000000
    long long _aLongLong = 637096692557458368
    unsigned int _anUnsignedInt = 60000
    unsigned char _anUnsignedChar = Ã¾
    unsigned long _anUnsignedLong = 2000000
    unsigned long long _anUnsignedLongLong = 637099437059560512
    unsigned short _anUnsignedShort = 0
    double _aDouble = 1.234000e-86
    float _aFloat = 6.700000e+35
    char* _aCharString = this is a message 
     read it carefully and
    Class _aClass = NSString
    id _anObject = <ObjectWithPrimitiveValues: 0x8a65f80>
    SEL _aSelector = initByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:

```





Installation
============

Add the *NSObject+Ivar* folder to your project
Add the header to your files

```
#import "NSObject+Ivar.h"
```

Use it!


