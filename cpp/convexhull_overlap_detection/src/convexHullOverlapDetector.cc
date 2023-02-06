#include "convexHullOverlapDetector.h"

namespace overlap_detector {

ConvexHullOverlapDetector::ConvexHullOverlapDetector
    (const std::shared_ptr<ConvexHullMap>& convex_hull_map,
    double overlap_rate_threshold)
    : convex_hull_map_(convex_hull_map)
    , overlap_rate_threshold_(overlap_rate_threshold) {
}

bool ConvexHullOverlapDetector::isOverlap(const ConvexHull& convex_hull1,
                                        const ConvexHull& convex_hull2) const {
    // Computational complexity is O(m * log(n)) in the worst case scenario
    // GJK would be a better alternative option for larger size
    // convex-hulls than the current impelmentation,
    // however, the current implementation is fast enough
    // for the convex-hull with n = 10~20.

    for (unsigned int i = 0; i < convex_hull1.getSize(); ++i) {
        Point target_point = convex_hull1.getApex(i);
        bool is_inside = isPointInsideConvexHull(target_point, convex_hull2);
        if (is_inside) return true;
    }
    return false;
}

ConvexHull ConvexHullOverlapDetector::getOverlapConvexHull
    (const ConvexHull& convex_hull1,
    const ConvexHull& convex_hull2) const {

    // scan points of convexHull1
    std::vector<int> in_convex_list1;
    for (unsigned int i = 0; i < convex_hull1.getSize(); ++i) {
        if (isPointInsideConvexHull(convex_hull1.getApex(i), convex_hull2)) {
            in_convex_list1.push_back(i);
        }
    }

    // scan points of convexHull2
    std::vector<int> in_convex_list2;
    for (unsigned int i = 0; i < convex_hull2.getSize(); ++i) {
        if (isPointInsideConvexHull(convex_hull2.getApex(i), convex_hull1)) {
            in_convex_list2.push_back(i);
        }
    }

    // No overlap
    if (in_convex_list1.empty() && in_convex_list1.empty()) {
        return ConvexHull();
    }

    // convexHull1 or convexHull2 fully encomposes the other
    if (in_convex_list1.empty()) {
        return convex_hull2;
    } else if (in_convex_list2.empty()) {
        return convex_hull1;
    }

    // Overlap case; attempt to get intersection points
    // Get two pairs of crossing segments
    Segment crossing_tail1;
    {
        const int idx = in_convex_list1.front();
        crossing_tail1.endpoint1 = convex_hull1.getApex(idx);
        crossing_tail1.endpoint2 = convex_hull1.getApex(idx-1);
    }

    Segment crossing_head1;
    {
        const int idx = in_convex_list1.back();
        crossing_head1.endpoint1 = convex_hull1.getApex(idx);
        crossing_head1.endpoint2 = convex_hull1.getApex(idx+1);
    }

    Segment crossing_tail2;
    {
        const int idx = in_convex_list2.front();
        crossing_tail2.endpoint1 = convex_hull2.getApex(idx);
        crossing_tail2.endpoint2 = convex_hull2.getApex(idx-1);
    }

    Segment crossing_head2;
    {
        const int idx = in_convex_list2.back();
        crossing_head2.endpoint1 = convex_hull2.getApex(idx);
        crossing_head2.endpoint2 = convex_hull2.getApex(idx+1);
    }

    Point sect1 = getIntersectionPoint(crossing_tail1, crossing_head2);
    Point sect2 = getIntersectionPoint(crossing_head1, crossing_tail2);

    // Construct overlap convex hull
    // Add apexes in a counter-clock-wise manner as below:
    // intersection point1
    // -> overlapped points of convexHull1,
    // -> intersection point 2
    // -> overlapped points of convexHull2
    ConvexHull overlap_convex_hull;
    overlap_convex_hull.addApex(sect1);
    for (const auto& idx : in_convex_list1) {
        overlap_convex_hull.addApex(convex_hull1.getApex(idx));
    }
    overlap_convex_hull.addApex(sect2);
    for (const auto& idx : in_convex_list2) {
        overlap_convex_hull.addApex(convex_hull2.getApex(idx));
    }

    return overlap_convex_hull;
}

Point ConvexHullOverlapDetector::getIntersectionPoint(const Segment& segment1,
    const Segment& segment2) const {
    // segment1: p1-p2
    // segment2: q1-q2
    // intersection point r = p1 - (p1-q1)x(q2-q1) / (p2-p1)x(q2-q1) * (p2 - p1)
    Point p1mq1, q2mq1, p2mp1;
    p1mq1 = segment1.endpoint1 - segment2.endpoint1;
    q2mq1 = segment2.endpoint2 - segment2.endpoint1;
    p2mp1 = segment1.endpoint2 - segment1.endpoint1;

    Point r = segment1.endpoint1
        - p2mp1 * (p1mq1.cross(q2mq1) / p2mp1.cross(q2mq1));
    return r;
}

bool ConvexHullOverlapDetector::eliminate() {
    // scan which convex-hull pair is overlapped
    std::vector<std::pair<int, int>> overlapped_pairs;
    for (const auto& iter1 : *convex_hull_map_) {
        for (const auto& iter2 : *convex_hull_map_) {
            // check if same convex hull pair or not
            if (iter1.first != iter2.first) {
                // check if overlapped
                if (isOverlap(iter1.second, iter2.second)) {
                    // add overlap pair if it's not added yet
                    std::pair<int, int> reverse_pair =
                        std::make_pair(iter2.first, iter1.first);
                    if (std::find(overlapped_pairs.begin(),
                                overlapped_pairs.end(), reverse_pair)
                        == overlapped_pairs.end())
                        overlapped_pairs.push_back(
                            std::make_pair(iter1.first, iter2.first));
                }
            }
        }
    }

#ifdef OVERLAP_DETECTOR_VERBOSE
std::cout << "Overlapped pairs detected: " << std::endl;
for (const auto& pair : overlapped_pairs) {
    std::cout << "(" << pair.first << " " << pair.second << ") ";
}
std::cout << std::endl << std::endl;
#endif

    // check if an area of overlap is larger than 50%
#ifdef OVERLAP_DETECTOR_VERBOSE
    std::cout << "Checking the overlap area ratio..." << std::endl << std::endl;
#endif
    std::set<int> remove_targets;
    for (const auto& pair : overlapped_pairs) {
        ConvexHull convex_hull1 = convex_hull_map_->at(pair.first);
        ConvexHull convex_hull2 = convex_hull_map_->at(pair.second);
        ConvexHull overlap_convex_hull =
            getOverlapConvexHull(convex_hull1, convex_hull2);
        if (overlap_convex_hull.getArea()
            >= convex_hull1.getArea() * overlap_rate_threshold_)
            remove_targets.insert(pair.first);
        if (overlap_convex_hull.getArea()
            >= convex_hull2.getArea() * overlap_rate_threshold_)
            remove_targets.insert(pair.second);

#ifdef OVERLAP_DETECTOR_VERBOSE
        std::cout << "Pair (" << pair.first << " "
                    << pair.second << "): overlap area is "
                    << overlap_convex_hull.getArea() << std::endl;
        std::cout << "Area of convex hull ID " << pair.first << ": "
                    << convex_hull1.getArea()
                    << " ("
                    << overlap_convex_hull.getArea() / convex_hull1.getArea() * 100.0
                    << "% occupied)" << std::endl;
        std::cout << "Area of convex hull ID " << pair.second << ": "
                    << convex_hull2.getArea()
                    << " ("
                    << overlap_convex_hull.getArea() / convex_hull2.getArea() * 100.0
                    << "% occupied)" << std::endl;
#endif
    }

    // eliminate
    for (const auto& id : remove_targets) {
        convex_hull_map_->erase(id);
    }
#ifdef OVERLAP_DETECTOR_VERBOSE
    std::cout << std::endl << "To be removed: " << std::endl;
    std::cout << "Convex hull ID: ";
    for (const auto& id : remove_targets) {
        std::cout << id << " ";
    }
    std::cout << std::endl;
#endif

    if (remove_targets.empty()) return false;
    return true;
}

bool ConvexHullOverlapDetector::isPointInsideConvexHull
    (const Point& point, const ConvexHull& convex_hull) const {
    // Assuming convexHull has apexes with counter-clock-wise order
    // Computational complexity is O(log(n)) thanks to a binary search manner
    // Please see the book "Real-time collision detection" pp. 201-203

    unsigned int low = 0;
    unsigned int high = convex_hull.getSize();
    while (low + 1 < high) {
        int mid = (low + high) / 2;
        if (isTriangleCCW(convex_hull.getApex(0),
                        convex_hull.getApex(mid), point))
            low = mid;
        else
            high = mid;
    }

    if (low == 0 || high == convex_hull.getSize()) return false;

    return isTriangleCCW(convex_hull.getApex(low),
                        convex_hull.getApex(high), point);
}

bool ConvexHullOverlapDetector::isTriangleCCW
    (const Point& apex1, const Point& apex2, const Point& apex3) const {
    // construct a hyperplance to check if triangle is
    // counter-clock-wise (in order with apex1, apex2, then apex3)
    // use points apex1 and apex2 for the hyperplane (a * x + b * y = c)
    Point base_vector = apex2 - apex1;
    Point base_point = apex1;
    double a = base_vector[1];
    double b = -base_vector[0];
    double c = base_vector[1] * base_point[0] - base_vector[0] * base_point[1];
    // triangle is CCW if a * x + b * y < c holds
    Point reference_point = apex3;
    if (a * reference_point[0] + b * reference_point[1] < c) {
        return true;
    }
    return false;
}
}  // namespace overlap_detector
