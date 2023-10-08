#include "controller.hpp"
#include <vector>
#include <memory>

class Controller1;

class StateOff : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateOff()
    {
        state_ = STATE::OFF;
    }

    void entry() override {
        std::cout << "Controller1 OFF::entry() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 OFF::doActivity() called." << std::endl;
    }

    void exit() override {
        std::cout << "Controller1 OFF::exit() called." << std::endl;
    }
private:
    Controller1* controller_;
};

class StateReady : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateReady()
    {
        state_ = STATE::READY;
    };

    void entry() override {
        std::cout << "Controller1 READY::entry() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 READY::doActivity() called." << std::endl;
    }

    void exit() override {
        std::cout << "Controller1 READY::exit() called." << std::endl;
    }
private:
    Controller1* controller_;
};

class StateRunning : public StateBase {
public:
    void setController(Controller1* controller) {controller_ = controller;}

    StateRunning()
    {
        state_ = STATE::RUNNING;
    };

    void entry() override {
        std::cout << "Controller1 RUNNING::exit() called." << std::endl;
    }

    void doActivity() override {
        std::cout << "Controller1 RUNNING::doActivity() called." << std::endl;
    }

    void exit() override {
        std::cout << "Controller1 RUNNING::exit() called." << std::endl;
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
                states_.push_back(state);
                stateManager_->addState(states_.back());
            }
            // Add READY state
            {
                std::shared_ptr<StateReady> state = std::make_shared<StateReady>();
                state->setController(this);
                states_.push_back(state);
                stateManager_->addState(states_.back());
            }
            // Add RUNNING state
            {
                std::shared_ptr<StateRunning> state = std::make_shared<StateRunning>();
                state->setController(this);
                states_.push_back(state);
                stateManager_->addState(states_.back());
            }

            // Set OFF state as initial state
            stateManager_->setInitialState(STATE::OFF);
        }
    private:
        std::vector<std::shared_ptr<State>> states_;
};
