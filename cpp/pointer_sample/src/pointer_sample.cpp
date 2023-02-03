#include "pointer_sample.hpp"

void function_1(int& a)
{
    a = 2;
}

void function_2(int* a)
{
    *a = 2;
}

void function_3(int a)
{
    a = 2;
}

void function_4(int a[])
{
    a[2] = 2;
}

void function_5(int* a)
{
    a[2] = 2;
}
