#include <iostream>
#include <memory>
#include <assert.h>
#include <unordered_map>

enum class STATE
{
    OFF=0,
    READY,
    RUNNING,
    NOT_DEFINED
};

class State 
{
public:
    virtual ~State() = default;
    virtual void entry() = 0;
    virtual void doActivity() = 0;
    virtual void exit() = 0;
    virtual bool isReadyToExit() = 0;
    virtual STATE getState() = 0;
};

class StateBase: public State
{
public:
    StateBase():isReadyToExit_(false) {}
    virtual void entry() override {}
    virtual void doActivity() override {}
    virtual void exit() override {}
    virtual bool isReadyToExit() override {return isReadyToExit_;}
    virtual STATE getState() override {return stateLabel_;}
    
protected:
    STATE stateLabel_;
    bool isReadyToExit_;
};

// Low Level State Manager to handle entry, doActivity, and exit
class StateManager
{
public:
    StateManager()
        : currentState_(STATE::NOT_DEFINED)
    {
    }
    virtual ~StateManager() = default;

    void addState(std::shared_ptr<State>&& state)
    {
        states_[state->getState()] = state;
    }

    void setInitialState(const STATE& initialState)
    {
        currentState_ = states_[initialState]->getState();
        states_[currentState_]->entry();
    }

    void switchState(const STATE& state)
    {
        assert(currentState_ != STATE::NOT_DEFINED);

        if (currentState_ != state)
        {
            states_[currentState_]->exit();
            currentState_ = states_[state]->getState();
            states_[currentState_]->entry();
        }
    }

    void request()
    {
        assert(currentState_ != STATE::NOT_DEFINED);

        states_[currentState_]->doActivity();
    }

    bool isReadyToExit()
    {
        assert(currentState_ != STATE::NOT_DEFINED);

        return states_[currentState_]->isReadyToExit();
    }

protected:
    std::unordered_map<STATE, std::shared_ptr<State>> states_;
    STATE currentState_;
};