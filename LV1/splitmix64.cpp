#ifdef __cplusplus

#define __STDC_CONSTANT_MACROS

#ifdef _STDINT_H

#undef _STDINT_H

#endif

# include <stdint.h>

#endif

#include <iostream>
#include <string>
using namespace std;


uint64_t x= 0x9e377;

uint64_t next() {
	uint64_t z = (x += 0x9e3779b97f4a7c15);
	z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9;
	z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
	return z ^ (z >> 31);
}


