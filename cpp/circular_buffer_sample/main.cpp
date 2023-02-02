#include <iostream>
#include <deque>
#include <boost/circular_buffer.hpp>

int main() {

    boost::circular_buffer<float> buffer(3);

    buffer.push_back(1);
    buffer.push_back(2);
    buffer.push_back(3);
    buffer.push_back(4);

    for(auto& buf: buffer)
    {
        std::cout << buf;
    }
    std::cout << std::endl;

    return 0;
}
