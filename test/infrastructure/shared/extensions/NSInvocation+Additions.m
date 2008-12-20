#import "NSInvocation+Additions.h"

#import "NSNull+X.h"

@implementation NSInvocation (Additions)

- (id) setArgs: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id invocation = [self setVargs:firstItem vaList:argList];
  va_end(argList); 
  return invocation;  
}

- (id) setVargs: (id)firstItem vaList: (va_list)argList {
  int numArgs = [[self methodSignature] numberOfArguments];
  
  const char* argType;
  if (!firstItem) {
    return self;
  }  
  int i;
  for (i = 2; i < numArgs; i++) {
    argType = [[self methodSignature] getArgumentTypeAtIndex:i];
    if((strlen(argType) > 1) && (argType[0] != '{'))
      [NSException raise:NSInvalidArgumentException format:@"NSInvocation+Additions: setVargs: Cannot handle argument type '%s'.", argType];     
    switch (argType[0]) {
      case '#':
      case ':':
      case '@': {
        id value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, id);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }
      case 'i': {
        int value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, int);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }
     case 's':
     {
       short value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = (short int)va_arg(argList, int);
        }
        [self setArgument:&value atIndex:i];            
        break;
     } 
      case 'l':
      {
        long value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, long);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'q':
      {
        long long value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, long long);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'c': {
        char value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = (char)va_arg(argList, int);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }        
      case 'C':
      {
        unsigned char value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = (unsigned char) va_arg(argList, unsigned int);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'I':
      {
        unsigned int value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, unsigned int);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'S':
      {
        unsigned short value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = (unsigned short)va_arg(argList, int);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'L':
      {
        unsigned long value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = (unsigned long)va_arg(argList, long);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'Q':
      {
        unsigned long long value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = va_arg(argList, unsigned long long);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'f': {
        float value;
        if (i == 2) {              
          [NSException raise:NSInvalidArgumentException format:@"Cannot handle float as the first argument"];
        }
        else {
          value = ((float)va_arg(argList, double));
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'd':
      {
        double value;
        if (i == 2) {              
          [NSException raise:NSInvalidArgumentException format:@"Cannot handle double as the first argument"];
        }
        else {
          value = va_arg(argList, double);
        }
        [self setArgument:&value atIndex:i];            
        break;
      }  
      case 'B':
      {
        BOOL value;
        if (i == 2) {              
          value = firstItem;
        }
        else {
          value = ((BOOL)va_arg(argList, int));
        }
        [self setArgument:&value atIndex:i];            
        break;
      }
      case '{': // structure
      {
        [NSException raise:NSInvalidArgumentException format:@"Cannot handle struct as the first argument"];
      }             
    }  
  }
  return self;
}

- (BOOL) boolArgAt: (int)index {
  BOOL arg;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (char) charArgAt: (int)index {
  char arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (double) doubleArgAt: (int)index {
  double arg;
  [self getArgument:&arg atIndex:index];
  return arg;    
}

- (float) floatArgAt: (int)index {
  float arg;
  [self getArgument:&arg atIndex:index];
  return arg;    
}

- (int) intArgAt: (int)index {
  int arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;
}

- (long) longArgAt: (int)index {
  long arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;
}

- (long long) longlongArgAt: (int)index {
  long long arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (id) objectArgAt: (int)index {
  id arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;
}

- (short int) shortArgAt: (int)index {
  short int arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (unsigned char) unsignedCharArgAt: (int)index {
  unsigned char arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (unsigned int) unsignedIntArgAt: (int)index {
  unsigned int arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (unsigned short) unsignedShortArgAt: (short)index {
  unsigned short arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (unsigned long) unsignedLongArgAt: (long)index {
  unsigned long arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

- (unsigned long long) unsignedLongLongArgAt: (long)index {
  unsigned long long arg = nil;
  [self getArgument:&arg atIndex:index];
  return arg;  
}

@end
