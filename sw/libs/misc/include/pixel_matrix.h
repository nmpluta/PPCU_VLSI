#pragma once

#include <array>
#include <cstdint>

class Pixel_matrix final {
public:
    static constexpr int rows{32};
    static constexpr int cols{32};

    Pixel_matrix() = default;
    Pixel_matrix(const Pixel_matrix &) = delete;
    Pixel_matrix(Pixel_matrix &&) = delete;
    Pixel_matrix &operator=(const Pixel_matrix &) = delete;
    Pixel_matrix &operator=(Pixel_matrix &&) = delete;

    std::array<std::array<uint16_t, cols>, rows> read_counters() const;
    void load_pixels_configs(const std::array<std::array<uint16_t, cols>, rows> &configs) const;
    void calibrate() const;

private:
    static constexpr int bits{16};

    void load_pixels_configs(const uint16_t config) const;
    std::array<std::array<uint16_t, cols>, rows> read() const;
    void write(const std::array<std::array<uint16_t, cols>, rows> &data) const;
    void write(const uint16_t value) const;
};

extern Pixel_matrix pixel_matrix;
