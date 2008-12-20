// ****************************************
// Generated from .m file
// ****************************************


@interface NSArray (X)
+ (id) empty;
+ (id) withVargs: (id)firstItem, ...;
+ (id) with: (id)firstItem vaList: (va_list)argList;
- (id) _initWithVargs: (id)firstItem, ...;
- (id) _initWith: (id)firstItem vaList: (va_list)argList;
- (id) as2D: (int)sizeOfInnerArrays;
- (id) asHash;
- (id) at: (NSUInteger)index;
- (id) collect;
- (id) compact;
- (BOOL) contains: (id)object;
- (id) eachDo;
- (id) first;
- (id) from: (int)startIndex to: (int)endIndexInclusive;
- (id) from: (int)startIndex withLength: (int)length;
- (id) get: (NSUInteger)index;
- (BOOL) isEmpty;
- (id) join: (id)joiningString;
- (id) last;
- (NSUInteger) length;
- (id) map;
- (id) higherOrderMethodSignatureForSelector:(SEL)selector;
- (id) sortBy: (id)selectorString;
- (id) range: (NSRange)range;
- (NSUInteger) size;
- (id) _collect: (id)higherOrderMethodInvocation;
- (id) _doNothing;
- (id) _eachDo: (id)higherOrderMethodInvocation;
@end
