#include <iostream>
#include <Eigen/Dense>

using namespace Eigen;

using Vector8d = Matrix<double, 8, 1>;
using Matrix8d = Matrix<double, 8, 8>;

int main()
{

    constexpr int n = 8;

    Vector2d a;
    Vector3d b;
    VectorXd c = VectorXd::Zero(8);
    Matrix<double, n, 1> d;
    Matrix<double, n, Dynamic> e;
    Matrix<double, Dynamic, Dynamic> f;
    Vector8d g;

}
