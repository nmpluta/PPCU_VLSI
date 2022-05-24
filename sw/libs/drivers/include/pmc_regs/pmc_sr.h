#pragma once

#include <cstdint>

/**
 * union Pmc_sr - Pixel Matrix Controller status register
 * @wtt: waiting for a trigger
 * @res: the reserved bits
 * @val: the register value
 */
union Pmc_sr {
    struct {
        uint32_t wtt : 1;
        uint32_t res : 31;
    };
    uint32_t val;
};
