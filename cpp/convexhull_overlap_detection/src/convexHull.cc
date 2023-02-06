#include "convexHull.h"

namespace overlap_detector {

double& Point::operator[](int n) {
    return data_[n];
}

Point& Point::operator=(const Point &other) {
    if (this != &other) {
        data_ = other.data_;
    }
    return *this;
}

const std::array<double, 2>& Point::getData() const {
    return data_;
}

const Point Point::operator+(const Point& rhs) const {
    Point tmp;
    for (size_t i = 0; i < data_.size(); ++i) {
        tmp[i] = data_[i] + rhs.getData()[i];
    }
    return tmp;
}

const Point Point::operator-(const Point& rhs) const {
    Point tmp;
    for (size_t i = 0; i < data_.size(); ++i) {
        tmp[i] = data_[i] - rhs.getData()[i];
    }
    return tmp;
}

const Point Point::operator*(double rhs) const {
    Point tmp;
    for (size_t i = 0; i < data_.size(); ++i) {
        tmp[i] = data_[i] * rhs;
    }
    return tmp;
}

double Point::cross(const Point& rhs) const {
    // compute cross product of two-dimensional vectors
    // a = [a1, a2]^T, b=[b1, b2]^T -> a.cross(b) = a1 * b2 - a2 * b1
    return data_[0] * rhs.getData()[1] - data_[1] * rhs.getData()[0];
}

double Point::dot(const Point& rhs) const {
    // compute dot product of two-dimensional vectors
    // a = [a1, a2]^T, b=[b1, b2]^T -> a.cross(b) = a1 * b1 + a2 * b2
    return data_[0] * rhs.getData()[0] + data_[1] * rhs.getData()[1];
}

ConvexHull::ConvexHull()
    : area_(0.0)
    , apexes_(std::vector<Point>()) {
}

ConvexHull& ConvexHull::operator=(const ConvexHull &other) {
    if (this != &other) {
        area_ = other.area_;
        apexes_ = other.apexes_;
    }
    return *this;
}

void ConvexHull::addApex(const Point& apex) {
    // add apex
    apexes_.push_back(apex);

    // update area
    area_ = computeConvexHullArea();
}

Point ConvexHull::getApex(int index) const {
    if (index < 0) {
        return apexes_[getSize() + index % getSize()];
    } else if (index >= static_cast<int>(getSize())) {
        return apexes_[index % getSize()];
    } else {
        return apexes_[index];
    }
}

double ConvexHull::computeConvexHullArea() const {
    double area = 0.0;

    // Assuming convex hull is stored counter-clock-wise,
    // an area can be computed using cross product of vectors
    // from any point to two adjacent apexes,
    // and the total area is equal to the sum of cross product divided by two

    if (!apexes_.empty()) {
        for (size_t i = 0; i < apexes_.size()-1; ++i) {
            area += apexes_[i].cross(apexes_[i+1]);
        }
        area += apexes_.back().cross(apexes_.front());
        area /= 2.0;
    }

    return area;
}
}  // namespace overlap_detector
