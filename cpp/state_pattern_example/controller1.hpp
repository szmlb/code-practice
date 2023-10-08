#include "controller.hpp"
#include <vector>
#include <memory>

class Controller1;

class StateOff : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateOff()
    {
        stateLabel_ = STATE::OFF;
    }

    void entry() override {
        std::cout << "Controller1 OFF::entry() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 OFF::doActivity() called." << std::endl;
        isReadyToExit_ = true;
    }

    void exit() override {
        std::cout << "Controller1 OFF::exit() called." << std::endl;
        isReadyToExit_ = false;
    }
private:
    Controller1* controller_;
};

class StateReady : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateReady()
    {
        stateLabel_ = STATE::READY;
    };

    void entry() override {
        std::cout << "Controller1 READY::entry() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 READY::doActivity() called." << std::endl;
        isReadyToExit_ = true;
    }

    void exit() override {
        std::cout << "Controller1 READY::exit() called." << std::endl;
        isReadyToExit_ = false;
    }
private:
    Controller1* controller_;
};

class StateRunning : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateRunning()
    {
        stateLabel_ = STATE::RUNNING;
    };

    void entry() override {
        std::cout << "Controller1 RUNNING::exit() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 RUNNING::doActivity() called." << std::endl;
        isReadyToExit_ = true;
    }

    void exit() override {
        std::cout << "Controller1 RUNNING::exit() called." << std::endl;
        isReadyToExit_ = false;
    }
private:
    Controller1* controller_;
};

class Controller1 : public ControllerBase
{
    public:
        Controller1(){};
        void createStateManager() override {
            stateManager_ = std::make_unique<StateManager>();
            // Add OFF state
            {
                std::shared_ptr<StateOff> state = std::make_shared<StateOff>();
                state->setController(this);
                stateManager_->addState(state);
            }
            // Add READY state
            {
                std::shared_ptr<StateReady> state = std::make_shared<StateReady>();
                state->setController(this);
                stateManager_->addState(state);
            }
            // Add RUNNING state
            {
                std::shared_ptr<StateRunning> state = std::make_shared<StateRunning>();
                state->setController(this);
                stateManager_->addState(state);
            }

            // Set OFF state as initial state
            stateManager_->setInitialState(STATE::OFF);
        }
};
