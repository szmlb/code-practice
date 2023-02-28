#include <atomic>
#include <chrono>
#include <random>
#include <tabulate/tabulate.hpp>
#include <thread>
#include <sstream>

template <typename T>
std::string to_string_with_precision(const T a_value, const int n = 4)
{
    std::ostringstream out;
    out.precision(n);
    out << std::fixed << a_value;
    return out.str();
}

using namespace tabulate;
using Row_t = Table::Row_t;
std::atomic_bool keep_running(true);

void waitingForWorkEnterKey() {
  while (keep_running) {
    if (std::cin.get() == 10) {
      keep_running = false;
    }
  }
  return;
}

int main() {
  std::thread tUserInput(waitingForWorkEnterKey);
  while (keep_running) {
    Table process_table;
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0, 1);
    process_table.add_row(Row_t{"Component", "ID", "position\n""[deg]", "velocity\n""[deg/s]", "torque\n""[Nm]", "Operation\n""enabled"});
    process_table.add_row(Row_t{"Arm", 
                                std::to_string((int)0),
                                to_string_with_precision(0.05, 3),
                                to_string_with_precision(0.05, 4), 
                                to_string_with_precision(0.05, 5), 
                                std::to_string((int)true)});
    process_table.add_row(Row_t{"Arm", 
                                std::to_string((int)1),
                                to_string_with_precision(0.05, 3),
                                to_string_with_precision(0.05, 4), 
                                to_string_with_precision(0.05, 5), 
                                std::to_string((int)true)});

    process_table.column(2).format().font_align(FontAlign::right);
    process_table.column(3).format().font_align(FontAlign::right);
    process_table.column(4).format().font_align(FontAlign::right);

    for (size_t i = 0; i < 6; ++i) {
            process_table[0][i]
                .format()
                .font_color(Color::yellow)
                .font_align(FontAlign::center)
                .width(12)
                .font_style({FontStyle::bold});
    }

    for (size_t i = 1; i < 3; ++i) {
            process_table[i][5]
                .format()
                .font_background_color(Color::green);
    }
    std::cout << process_table << std::endl;
    std::cout << "Press ENTER to exit..." << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  }
  tUserInput.join();

  return 0;
}