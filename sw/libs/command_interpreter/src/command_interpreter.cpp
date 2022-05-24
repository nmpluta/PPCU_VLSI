#include "command_interpreter.h"
#include "core.h"
#include "debug.h"
#include "gpio.h"
#include "pixel_matrix.h"
#include "pmc.h"
#include "uart.h"
#include "ui.h"

void Command_interpreter::run() const
{
    while (1) {
        switch (read_command()) {
        case Command::help:
            help();
            break;
        case Command::set_led:
            set_led();
            break;
        case Command::read_matrix:
            read_matrix();
            break;
        case Command::calibrate_matrix:
            calibrate_matrix();
            break;
        case Command::unrecognized:
            uart.write("unrecognized command\n");
            break;
        }
    }
}

Command Command_interpreter::read_command() const
{
    char buf[100];
    uart.write("> ");
    uart.read(buf, sizeof(buf));
    return command_parser.parse(buf);
}

void Command_interpreter::help() const
{
    static constexpr auto message{
        "help             - print this message\n"
        "set_led          - set led\n"
        "read_matrix      - read matrix counters\n"
        "calibrate_matrix - calibrate pixels offsets\n"
    };
    uart.write(message);
}

void Command_interpreter::set_led() const
{
    const auto pin{Ui::get_integer("pin")};
    const auto state{static_cast<bool>(Ui::get_integer("state"))};
    gpio.set_pin(pin, state);
}

void Command_interpreter::read_matrix() const
{
    pmc.set_din(0, 0);

    const auto start{core.get_performance_counter()};
    const auto counters{pixel_matrix.read_counters()};
    const auto stop{core.get_performance_counter()};
    const auto readout_time{static_cast<uint32_t>(stop - start)};
    uart.write("readout finished\n");
    debug_dec_word(readout_time);

    for (int col = 0; col < Pixel_matrix::cols; ++col)
        Debugger::print_hex_word(counters[Pixel_matrix::rows - 1][col]);
}

void Command_interpreter::calibrate_matrix() const
{
    pmc.set_dc(64);
    pmc.set_din(0, 0);

    const auto start{core.get_performance_counter()};
    pixel_matrix.calibrate();
    const auto stop{core.get_performance_counter()};
    const auto calibration_time{static_cast<uint32_t>(stop - start)};
    uart.write("offset calibration done\n");
    debug_dec_word(calibration_time);
}
