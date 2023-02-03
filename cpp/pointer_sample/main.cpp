#include <iostream>
#include "pointer_sample.hpp"

int main(int, char**) {

    // 1. variable
    int var;

    var = 4;
    function_1(var);
    std::cout << "function_1 (main): " << var << std::endl;

    var = 4;
    function_2(&var);
    std::cout << "function_2 (main): " << var << std::endl;

    var = 4;
    function_3(var);
    std::cout << "function_3 (main): " << var << std::endl;

    // 2. array
    int array[3];

    array[0] = array[1] = array[2] = 0.0;
    function_4(array);
    std::cout << "function_4 (main): " << array[2] << std::endl;

    array[0] = array[1] = array[2] = 0.0;
    function_5(array);
    std::cout << "function_5 (main): " << array[2] << std::endl;

}
