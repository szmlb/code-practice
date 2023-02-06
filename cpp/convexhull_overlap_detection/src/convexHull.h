#ifndef SRC_CONVEXHULL_H_
#define SRC_CONVEXHULL_H_

#include <vector>
#include <array>
#include <map>

namespace overlap_detector {

// A class to handle two-dimensional vector and its arithmetic operation
class Point {
 public:
    Point(): data_({0.0, 0.0}) {}
    Point(double x, double y) {data_[0] = x; data_[1] = y;}
    Point(const Point& other) {data_ = other.data_;}
    Point& operator=(const Point &other);
    double& operator[](int n);
    const std::array<double, 2>& getData() const;
    const Point operator+(const Point& rhs) const;
    const Point operator-(const Point& rhs) const;
    const Point operator*(double rhs) const;
    double cross(const Point& rhs) const;
    double dot(const Point& rhs) const;
 private:
    std::array<double, 2> data_;
};

// A class to handle a segment which consists of two end points
struct Segment{
    Point endpoint1;
    Point endpoint2;
    Segment()
        : endpoint1(Point(0.0, 0.0))
        , endpoint2(Point(0.0, 0.0))
    {}
};

// A class to use a convex-hull, managing its apexes and an area computation
class ConvexHull {
 public:
    ConvexHull();
    ConvexHull(const ConvexHull& other)
        {area_ = other.area_; apexes_ = other.apexes_;}
    ConvexHull& operator=(const ConvexHull &other);
    void addApex(const Point& apex);
    Point getApex(int index) const;
    unsigned int getSize()const {return apexes_.size();}
    double getArea() {return area_;}
 private:
    double area_;
    std::vector<Point> apexes_;
    double computeConvexHullArea() const;
};

// A map of convex-hull data associated with its ID (as a key).
// std::map is used instead of std::unordered_map to make apexes ID ordered
using ConvexHullMap = std::map<int, ConvexHull>;

}  // namespace overlap_detector

#endif  // SRC_CONVEXHULL_H_
