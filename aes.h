#ifndef _AES_H_
#define _AES_H_

#include <stdint.h>
#include <stddef.h>

// The #ifndef-guard allows it to be configured before #include'ing or at compile time.
#define AES_KEYLEN 16 // Key length in bytes

struct AES_ctx
{
  uint8_t RoundKey[AES_KEYLEN];
};

void AES_init_ctx(struct AES_ctx* ctx, const uint8_t* key);
void AES128Encrypt(struct AES_ctx* ctx, uint8_t* buf);

#endif // _AES_H_
