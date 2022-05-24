#include "pixel_matrix.h"
#include <rvintrin.h>
#include "pmc.h"

#define is_bit_set(word, bit) \
({ \
    _rv32_sbext(word, bit); \
})

#define set_bit(word, bit) \
({ \
    word = _rv32_sbset(word, bit); \
})

#define clear_bit(word, bit) \
({ \
    word = _rv32_sbclr(word, bit); \
})

Pixel_matrix pixel_matrix;

std::array<std::array<uint16_t, Pixel_matrix::cols>, Pixel_matrix::rows> Pixel_matrix::read_counters() const
{
    return read();
}

void Pixel_matrix::load_pixels_configs(
    const std::array<std::array<uint16_t, Pixel_matrix::cols>, Pixel_matrix::rows> &configs) const
{
    write(configs);
    pmc.get_pmcc().load_config_latcher();
}

void Pixel_matrix::calibrate() const
{
    struct Config {
        uint16_t offset;
        uint16_t counts;
    };
    std::array<std::array<Config, Pixel_matrix::cols>, Pixel_matrix::rows> configs;
    for (auto &row : configs) {
        for (auto &config : row)
            config.counts = 0;
    }

    for (int i = 0; i < 128; ++i) {
        load_pixels_configs(i);

        pmc.get_pmcc().load_hits_generator();
        while (!pmc.get_pmcc().is_waiting_for_trigger()) { }
        pmc.get_pmcc().trigger();

        const auto readout{read()};
        for (int row = 0; row < rows; ++row) {
            for (int col = 0; col < cols; ++col) {
                if (readout[row][col] > configs[row][col].counts) {
                    configs[row][col].offset = i;
                    configs[row][col].counts = readout[row][col];
                }
            }
        }
    }

    std::array<std::array<uint16_t, Pixel_matrix::cols>, Pixel_matrix::rows> found_configs;
    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col)
            found_configs[row][col] = configs[row][col].offset;
    }
    load_pixels_configs(found_configs);
}

void Pixel_matrix::load_pixels_configs(const uint16_t config) const
{
    write(config);
    pmc.get_pmcc().load_config_latcher();
}

std::array<std::array<uint16_t, Pixel_matrix::cols>, Pixel_matrix::rows> Pixel_matrix::read() const
{
    std::array<std::array<uint16_t, cols>, rows> data;
    pmc.get_pmcc().load_data_shifter();

    for (int row = rows - 1; row >= 0; --row) {
        for (int bit = bits - 1; bit >= 0; --bit) {
            const uint32_t dout{pmc.get_dout_low()};
            for (int col = 0; col < cols; ++col) {
                if (is_bit_set(dout, col))
                    set_bit(data[row][col], bit);
                else
                    clear_bit(data[row][col], bit);
            }
            while (!pmc.get_pmcc().is_waiting_for_trigger()) { }
            pmc.get_pmcc().trigger();
        }
    }
    return data;
}

void Pixel_matrix::write(const std::array<std::array<uint16_t, cols>, rows> &data) const
{
    pmc.get_pmcc().load_data_shifter();

    for (int row = rows - 1; row >= 0; --row) {
        for (int bit = bits - 1; bit >= 0; --bit) {
            uint32_t din{0};
            for (int col = 0; col < cols; ++col) {
                if (is_bit_set(data[row][col], bit))
                    set_bit(din, col);
                else
                    clear_bit(din, col);
            }
            pmc.set_din_low(din);
            while (!pmc.get_pmcc().is_waiting_for_trigger()) { }
            pmc.get_pmcc().trigger();
        }
    }
}

void Pixel_matrix::write(const uint16_t value) const
{
    pmc.get_pmcc().load_data_shifter();

    for (int row = rows - 1; row >= 0; --row) {
        for (int bit = bits - 1; bit >= 0; --bit) {
            uint32_t din{0};
            for (int col = 0; col < cols; ++col) {
                if (is_bit_set(value, bit))
                    set_bit(din, col);
                else
                    clear_bit(din, col);
            }
            pmc.set_din_low(din);
            while (!pmc.get_pmcc().is_waiting_for_trigger()) { }
            pmc.get_pmcc().trigger();
        }
    }
}
