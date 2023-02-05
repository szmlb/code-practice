#include <chrono>
#include <vector>
#include <iostream>
#include <cmath>

class PrimeCalculator {
public:
    PrimeCalculator(int limit) : m_limit(limit) {}

    std::vector<int> get_primes() {
        std::vector<int> primes;
        for (int i = 2; i <= m_limit; i++) {
            bool is_prime = true;
            for (int j = 2; j <= std::sqrt(i); j++) {
                if (i % j == 0) {
                    is_prime = false;
                    break;
                }
            }
            if (is_prime) {
                primes.push_back(i);
            }
        }
        return primes;
    }

private:
    int m_limit;
};

class Stopwatch {
public:
    Stopwatch()
        : m_start(std::chrono::high_resolution_clock::now())
    {}

    void check() {
        auto now = std::chrono::high_resolution_clock::now();
        m_checkpoints.push_back(now - m_start);
        m_start = now;
    }

    double get_last_duration() const {
        return std::chrono::duration_cast<std::chrono::microseconds>(m_checkpoints.back()).count() / 1e6;
    }

    void print_durations() const {
        int i = 0;
        for (auto &checkpoint : m_checkpoints) {
            std::cout << "Checkpoint " << i++ << ": " << std::chrono::duration_cast<std::chrono::microseconds>(checkpoint).count() / 1e6 << " seconds" << std::endl;
        }
    }

private:
    std::chrono::time_point<std::chrono::high_resolution_clock> m_start;
    std::vector<std::chrono::duration<double>> m_checkpoints;
};

int main()
{
    const int limits[] = {100, 10000, 100000};
    for (const int &limit : limits) {
        PrimeCalculator calculator(limit);

        Stopwatch stopwatch;

        // Block of code you want to measure the processing time of
        auto primes = calculator.get_primes();
        stopwatch.check();

        std::cout << "A number of prime numbers up to " << limit << ": " << primes.size() << std::endl;
        std::cout << "Processing time: " << stopwatch.get_last_duration() << " seconds" << std::endl;
    }

    return 0;
}
