#include <iostream>

namespace myspace
{

    class MyHelper final
    {
        public:
            MyHelper() = delete;
            ~MyHelper() = delete;
        public:
            static int Add(int x,  int y);
    };

    int MyHelper::Add(int x,  int y)
    {
        return x + y;
    }

}
