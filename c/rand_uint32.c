#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>



#ifdef __linux__
#include <linux/random.h>

uint32_t
linux_uint32()
{
    uint32_t buf;

    #ifdef SYS_getrandom
    if (getrandom(&buf, sizeof(uint32_t), 0) == -1) {
        printf("getrandom() failed\n");
        exit(EXIT_FAILURE);
    }

    return buf;
    #endif

    int urandom = open("/dev/urandom", O_RDONLY);
    if (read(urandom, &buf, sizeof(uint32_t)) != sizeof(uint32_t)) {
        printf("/dev/urandom read failure\n");
        exit(EXIT_FAILURE);
    }
    close(urandom);

    return buf;
}

// Credit: OpenBSD's arc4random_uniform()
uint32_t
linux_uint32_uniform(uint32_t upper_bound)
{
    uint32_t r, min;

    if (upper_bound < 2)
        return 0;

    min = -upper_bound % upper_bound;
    
    for (;;) {
        r = linux_uint32();
        if (r >= min)
            break;
    }

    return r % upper_bound;
}

#endif

uint32_t rand_uint32_uniform(uint32_t upper_bound) {
    #ifdef __linux__
    return linux_uint32_uniform(upper_bound);
    #else
    return arc4random_uniform(upper_bound);
    #endif
}
