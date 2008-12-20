@interface NSInvocation (Additions)

- (char) charArgAt: (int)index;
- (double) doubleArgAt: (int)index;
- (float) floatArgAt: (int)index;
- (int) intArgAt: (int)index;
- (long) longArgAt: (int)index;
- (long long) longlongArgAt: (int)index;
- (id) objectArgAt: (int)index;
- (short int) shortArgAt: (int)index;
- (unsigned char) unsignedCharArgAt: (int)index;
- (id) _extractArgumentAtIndex:(int)index;

@end
