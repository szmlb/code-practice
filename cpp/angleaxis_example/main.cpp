#include <iostream>
#include <Eigen/Core>
#include <Eigen/Geometry>

Eigen::Vector3d getAngularVelocityFromRotationMatrix(const Eigen::Matrix3d mat)
{
    double theta = acos( (mat.trace() - 1.0) / 2.0);
    Eigen::Vector3d ret;
    ret[0] = theta / (2.0 * sin(theta)) * (mat(2, 1) - mat(1, 2));
    ret[1] = theta / (2.0 * sin(theta)) * (mat(0, 2) - mat(2, 0));
    ret[2] = theta / (2.0 * sin(theta)) * (mat(1, 0) - mat(0, 1));
    return ret;
}

int main()
{
    Eigen::Vector3d axis;
    axis.setRandom();
    std::cout << axis << "\n\n";
    axis.normalize();
    std::cout << axis << "\n\n";

    Eigen::Matrix3d mat;
    mat = Eigen::AngleAxisd(0.256, axis);

    Eigen::AngleAxisd newAngleAxis(mat);

    std::cout << newAngleAxis.angle() << "\n" << newAngleAxis.axis() << "\n\n";

    std::cout << "Rotation vector calculated by our function:" << std::endl;
    std::cout << getAngularVelocityFromRotationMatrix(mat) << std::endl;

    std::cout << "Rotation vector calculated by Eigen" << std::endl;
    std::cout << newAngleAxis.angle() * newAngleAxis.axis() << std::endl;
    return 0;
}