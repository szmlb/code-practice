#include <iostream>
#include "controller1.hpp"
#include <unordered_map>

int main() {

    STATE state;
    std::unordered_map<CONTROLLER, std::shared_ptr<Controller>> controllers;
    controllers[CONTROLLER::CNTR1] = std::make_shared<Controller1>();
    controllers[CONTROLLER::CNTR1]->createStateManager();
    std::shared_ptr<Controller> controller;

    for (int i = 0; i < 100; ++i)
    {
        // High-level state manager (and also switches controller)
        controller = controllers[CONTROLLER::CNTR1];
        if (i < 20)
        {
            state = STATE::OFF;
        }
        else if(i < 60)
        {
            state = STATE::READY;
        }
        else
        {
            state = STATE::RUNNING;
        }

        switch(state) {
            case STATE::OFF:
                controller->runOff();
                break;
            case STATE::READY:
                controller->runReady();
                break;
            case STATE::RUNNING:
                controller->runRunning();
                break;
            default:
                // Do nothing
                break;
        }
    }

    return 0;
}
