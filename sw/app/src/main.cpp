#include "delay.h"
#include "gpio.h"

static constexpr uint32_t led_mask{0xf};

int main()
{
    while (true) {
        for (int i = 0; i < 16; ++i) {
            gpio.set_mask_bits(led_mask, i);
            mdelay(1000);
        }
    }
}
