#include <stdint.h>

void Bits2OctalString(uint8_t bits, char string[]) {
	uint8_t value = bits;
	char temp[4];
	int i = 0;
	
	while(value > 0) {
		temp[i++] = (value % 8) + '0';
		value /= 8;
	}
	
	int j = 0;
	while(i > 0) {
		string[j++] = temp[--i];
	}
	string[j] = '\0';
}

void Bits2UnsignedString(uint8_t bits, char string[]) {
	uint8_t value = bits;
	char temp[4];
	int i = 0;
	
	while(value > 0) {
		temp[i++] = (value % 10) + '0';
		value /= 10;
	}
	
	int j = 0;
	while(i > 0) {
		string[j++] = temp[--i];
	}
	string[j] = '\0';
}

void Bits2HexString(uint8_t bits, char string[]) {
	const char hex_chars[] = "0123456789ABCDEF";
	uint8_t high = (bits >> 4) & 0x0F;
	uint8_t low = bits & 0x0F;
	
	string[0] = hex_chars[high];
	string[1] = hex_chars[low];
	string[2] = '\0';
} // radix 16

void Bits2TwosCompString(uint8_t bits, char string[]) {
	if(bits & 1 <<7) {
		string[0] = '-';
		bits = ~bits + 1;
	} else {
		string[0] = '+';
	}

	 Bits2UnsignedString(bits, &string[1]);
}

void Bits2SignMagString(uint8_t bits, char string[]) {
	int i = 0;
	uint8_t sign = (bits & 0x80) >> 7;
	uint8_t magnitude = bits & 0x7F;
	
	if(magnitude == 0) {
		string[0] = '0';
		string[1] = '\0';
	}
	
	if(sign == 1) {
		string[i++] = '-';
	}
	
	char temp[4];
	int j = 0;
	
	while(magnitude > 0) {
		temp[j++] = (magnitude % 10) + '0';
		magnitude /= 10;
	}
	
	while(j > 0) {
		string[i++] = temp[--j];
	}
	
	string[i] = '\0';
}
