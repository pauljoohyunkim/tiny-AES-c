### Tiny AES128 in C

This is modified from [tiny-AES-c](https://github.com/kokke/tiny-AES-c) and [aes-min](https://github.com/cmcqueen/aes-min).

```C
/* Initialize context */
void AES_init_ctx(struct AES_ctx* ctx, const uint8_t* key);

/* Then start encrypting with the functions below: */
void AES_ECB_encrypt(const struct AES_ctx* ctx, uint8_t* buf);
```

C++ users should `#include` [aes.hpp](./aes.hpp) instead of [aes.h](./aes.h)

This implementation is verified against the data in:

[National Institute of Standards and Technology Special Publication 800-38A 2001 ED](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38a.pdf) Appendix F: Example Vectors for Modes of Operation of the AES.

#### Compilation
To compile the files, run any of the following:
```
make aes.o          // Tiny AES128 Implementation
make aes.a          // Archive File
make aes.csbox.o    // Even Tinier AES128 Implementation
make aes.csbox.a    // Even Tinier Archive File
make test           // Testing Tiny AES128
make test.csbox     // Testing Even Tinier AES128
```