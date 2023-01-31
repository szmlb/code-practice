#include <iostream>
#include <memory>

class sample
{
    public:
        int a;
        int b;
};

sample *rawPtr;

void function(std::unique_ptr<sample>& ptr)
{
    //std::unique_ptr<sample> ptr2(ptr.get());
    ptr.reset(rawPtr);
    std::cout << ptr->a << " " << ptr->b << std::endl;
}

int main() {

    std::unique_ptr<sample> ptr;
    ptr = std::make_unique<sample>();
    ptr->a = 2;
    ptr->b = 5;
    std::cout << ptr->a << " " << ptr->b << std::endl;

    // get raw pointer and set it to global variable
    rawPtr = ptr.get();

    // set the raw pointer to another unique_ptr
    std::unique_ptr<sample> ptr2;
    function(ptr2);
    std::cout << ptr2->a << " " << ptr2->b << std::endl;

    //check if ptr still has same pointer info.
    std::cout << ptr->a << " " << ptr->b << std::endl;

    // this is required
    ptr2.release(); // the program dies if this line is commeneted out

    // ptr still has value, can be safely released when getting out of scope
    std::cout << ptr->a << " " << ptr->b << std::endl;

    return 0;
}
