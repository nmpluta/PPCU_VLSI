#include "delay.h"
#include "gpio.h"

#define MAX(a, b) (((a) > (b)) ? (a) : (b))

static constexpr uint32_t led_mask{0xF};

// SOS: ... --- ...
static constexpr bool sos_morse[] = {1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1};

// Natalia:
static constexpr bool name_morse[] = {1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1};

// Pluta:
static constexpr bool surname_morse[] = {1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1};

int main()
{
    while (true)
    {
        uint8_t length_sos = sizeof(sos_morse) / sizeof(sos_morse[0]);
        uint8_t length_name = sizeof(name_morse) / sizeof(name_morse[0]);
        uint8_t length_surname = sizeof(surname_morse) / sizeof(surname_morse[0]);

        uint8_t max_length = MAX(MAX(length_sos, length_name), length_surname);

        for (int i = 0; i < max_length; ++i)
        {
            gpio.set_pin(0, true);

            if (i < length_sos)
            {
                gpio.set_pin(1, sos_morse[i]);
            }
            else
            {
                gpio.set_pin(1, false);
            }

            if (i < length_name)
            {
                gpio.set_pin(2, name_morse[i]);
            }
            else
            {
                gpio.set_pin(2, false);
            }

            if (i < length_surname)
            {
                gpio.set_pin(3, surname_morse[i]);
            }
            else
            {
                gpio.set_pin(3, false);
            }

            mdelay(1000);
        }

        gpio.set_pin(0, false);
        gpio.set_pin(1, false);
        gpio.set_pin(2, false);
        gpio.set_pin(3, false);
        mdelay(2000);
    }
}
