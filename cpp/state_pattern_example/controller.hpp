#include <iostream>
#include <memory>
#include "state.hpp"

enum class CONTROLLER
{
    CNTR1=0,
    CNTR2
};

class Controller
{
    public:
        virtual ~Controller() = default;
        virtual void createStateManager() = 0;
        virtual void runOff() = 0;
        virtual void runReady() = 0;
        virtual void runRunning() = 0;
        virtual bool isReadyToExit() = 0;
};

class ControllerBase : public Controller
{
    public:

        virtual void createStateManager()
        {
            // To be implemented
        }

        void runOff()
        {
            stateManager_->switchState(STATE::OFF);
            stateManager_->request();
        }

        void runReady()
        {
            stateManager_->switchState(STATE::READY);
            stateManager_->request();
        }

        void runRunning()
        {
            stateManager_->switchState(STATE::RUNNING);
            stateManager_->request();
        }

        bool isReadyToExit()
        {
            return stateManager_->isReadyToExit();
        }

    protected:
        std::unique_ptr<StateManager> stateManager_;
};