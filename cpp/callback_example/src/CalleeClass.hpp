class CalleeClass {
public:
      CalleeClass() : count(0){};
      int callbackMethod(int num1, int num2) {
          return num1 + num2;
      }
      int callbackCounter()
      {
        count++;
        return count;
      }
private:
    int count;
};