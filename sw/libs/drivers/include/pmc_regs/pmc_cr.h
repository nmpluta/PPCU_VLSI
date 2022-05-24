#pragma once

#include <cstdint>

/**
 * union Pmc_cr - Pixel Matrix Controller control register
 * @en: the PMCC enable
 * @rst: the PMCC reset
 * @trg: the PMCC trigger
 * @res: the reserved bits
 * @val: the register value
 */
union Pmc_cr {
    struct {
        uint32_t en : 1;
        uint32_t rst : 1;
        uint32_t trg : 1;
        uint32_t res : 29;
    };
    uint32_t val;
};
