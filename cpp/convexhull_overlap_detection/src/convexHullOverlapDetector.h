#ifndef SRC_CONVEXHULLOVERLAPDETECTOR_H_
#define SRC_CONVEXHULLOVERLAPDETECTOR_H_

#include <iostream>
#include <algorithm>
#include <memory>
#include <vector>
#include <utility>
#include <set>
#include "convexHull.h"

namespace overlap_detector {

// A class to detect overlapped convex hulls by checking
// a state of apexes if they are inside of the paird convex hull
// the class is able to eliminate convex hulls if
// the convex hulls overlap and its overlap convex hull ocupies
// more than the rate specified by users
class ConvexHullOverlapDetector {
 public:
    ConvexHullOverlapDetector
        (const std::shared_ptr<ConvexHullMap>& convexHullMap,
        double overlapRateThreshold);
    virtual ~ConvexHullOverlapDetector() {}
    bool isOverlap(const ConvexHull& convexHull1,
                const ConvexHull& convexHull2) const;
    bool isPointInsideConvexHull(const Point& point,
                                const ConvexHull& convexHull) const;
    ConvexHull getOverlapConvexHull(const ConvexHull& convexHull1,
                                    const ConvexHull& convexHull2) const;
    Point getIntersectionPoint(const Segment& segment1,
                            const Segment& segment2) const;
    bool isTriangleCCW(const Point& apex1,
                    const Point& apex2, const Point& apex3) const;
    bool eliminate();
 private:
    std::shared_ptr<ConvexHullMap> convex_hull_map_;
    const double overlap_rate_threshold_;
};

}  // namespace overlap_detector

#endif  // SRC_CONVEXHULLOVERLAPDETECTOR_H_
