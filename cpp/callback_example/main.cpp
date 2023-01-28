#include <iostream>
#include <functional>
#include "./src/CallerClass.hpp"
#include "./src/CalleeClass.hpp"

int main()
{
    CallerClass caller;
    CalleeClass callee;

    caller.setCallback(std::bind(&CalleeClass::callbackMethod, callee, std::placeholders::_1, std::placeholders::_2));
    caller.useCallback();

    caller.setCallbackCounter(std::bind(&CalleeClass::callbackCounter, callee));
    caller.useCallbackCounter();
    caller.useCallbackCounter();
    caller.useCallbackCounter();

}