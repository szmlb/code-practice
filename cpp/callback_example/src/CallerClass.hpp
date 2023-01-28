#include <functional>
#include <iostream>

class CallerClass {
public:
	void setCallback(std::function<int(int, int)> callback) 
    {
        callback1_ = callback;
	}

	void setCallbackCounter(std::function<int(void)> callback) 
    {
        callback2_ = callback;
	}

    void useCallback()
    {
        int o = callback1_(1, 2);
        std::cout << "Value: " << o << std::endl;
    }

    void useCallbackCounter()
    {
        int o = callback2_();
        std::cout << "Counter value: " << o << std::endl;
    }

private:
    std::function<int(int, int)> callback1_;
    std::function<int(void)> callback2_;

};