#include "delay.h"
#include "gpio.h"

static constexpr uint32_t led_mask{0xF};


// SOS: ... --- ...
static constexpr bool sos_morse[] = { 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1 };

// Natalia:  
static constexpr bool name_morse[] = { 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1 };

// Pluta:
static constexpr bool surname_morse[] = {1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1};

int main()
{
    while (true) 
    {
        for (int i = 0; i < 16; ++i) 
        {
            gpio.set_mask_bits(led_mask, i);
            // gpio.set_pin(0, true);

            // gpio.set_pin(1, 1);
            // gpio.set_pin(2, 0);
            // gpio.set_pin(3, 1);
            mdelay(1000);
        }
    }
}
