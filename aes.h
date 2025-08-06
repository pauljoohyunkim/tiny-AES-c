#ifndef _AES_H_
#define _AES_H_

#include <stdint.h>
#include <stddef.h>

// The #ifndef-guard allows it to be configured before #include'ing or at compile time.
#define AES128 1
#define AES_BLOCKLEN 16 // Block length in bytes - AES is 128b block only
#define AES_KEYLEN 16 // Key length in bytes
#define AES_keyExpSize 176

struct AES_ctx
{
  uint8_t RoundKey[AES_KEYLEN];
};

void AES_init_ctx(struct AES_ctx* ctx, const uint8_t* key);

void AES_ECB_encrypt(struct AES_ctx* ctx, uint8_t* buf);

#endif // _AES_H_
