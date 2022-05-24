#pragma once

#include <array>
#include "pmc_ac.h"
#include "pmc_cr.h"
#include "pmc_ctrl.h"
#include "pmc_dc.h"
#include "pmc_sr.h"
#include "pmcc.h"

class Pmc final {
public:
    Pmc(const uint32_t base_address);
    Pmc(const Pmc &) = delete;
    Pmc(Pmc &&) = delete;
    Pmc &operator=(const Pmc &) = delete;
    Pmc &operator=(Pmc &&) = delete;

    Pmcc &get_pmcc() { return pmcc; };

    void set_din_low(const uint32_t value) const volatile;
    void set_din(const uint32_t low, const uint32_t high) const volatile;
    uint32_t get_dout_low() const volatile;
    void set_ac(const std::array<uint32_t,4> &ac) const volatile;
    void set_dc(const uint32_t dc) const volatile;

private:
    volatile Pmc_cr * const cr;
    volatile Pmc_sr * const sr;
    volatile Pmc_ctrl * const ctrl;
    volatile uint32_t * const din_low;
    volatile uint32_t * const din_high;
    volatile uint32_t * const dout_low;
    volatile uint32_t * const dout_high;
    volatile Pmc_ac * const ac;
    volatile Pmc_dc * const dc;

    Pmcc pmcc;
};

extern Pmc pmc;
