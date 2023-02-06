// Copyright (c) 2022 Akihiro Suzumura. All rights reserved.
// This code follows the Google C++ style guide (https://google.github.io/styleguide/cppguide.html)
// and checked with cpplint (https://github.com/cpplint/cpplint)

#include <iostream>
#include <memory>
#include "../src/convexHull.h"
#include "../src/convexHullParser.h"
#include "../src/convexHullOverlapDetector.h"

int main() {
    // the convex hull data to be loaded, edited, then saved
    std::shared_ptr<overlap_detector::ConvexHullMap> convex_hull_map
        = std::make_shared<overlap_detector::ConvexHullMap>();

    // setup a convex hull parser
    overlap_detector::ConvexHullParser parser(convex_hull_map);
    parser.parse(input_jsonfile_path);

    // detect & eliminate overlapped convex hulls (while checking its overlap rate)
    overlap_detector::ConvexHullOverlapDetector detector(convex_hull_map,
                                                        overlap_rate_threshold);
    // test code for isTriangleCCW()
    {
        Point p1(0.0, 0.0);
        Point p2(0.3, -0.3);
        Point p3(0.3, -0.15);
        if(detector.isTriangleCCW(p1, p2, p3))
        {
            std::cout << "CCW" << std::endl;
        }
    }

    // test code for isPointInsideConvexHull()
    {
        Point p1(0.0, 1.0);
        Point p2(-1.0, 0.0);
        Point p3(0.0, -1.0);
        Point p4(1.0, 0.0);
        ConvexHull hull;
        hull.addApex(p1);
        hull.addApex(p2);
        hull.addApex(p3);
        hull.addApex(p4);
        Point pcheck(0.9999999, 0.0);
        if(detector.isPointInsideConvexHull(pcheck, hull))
        {
            std::cout << "Inside" << std::endl;
        }
    }

    // test code for isOverlap()
    {
        Point p11(0.0, 1.0);
        Point p12(-1.0, 0.0);
        Point p13(0.0, -1.0);
        Point p14(1.0, 0.0);
        ConvexHull hull1;
        hull1.addApex(p11);
        hull1.addApex(p12);
        hull1.addApex(p13);
        hull1.addApex(p14);

        Point shift(1.99, 0.0);
        Point p21 = p11 + shift;
        Point p22 = p12 + shift;
        Point p23 = p13 + shift;
        Point p24 = p14 + shift;
        ConvexHull hull2;
        hull2.addApex(p21);
        hull2.addApex(p22);
        hull2.addApex(p23);
        hull2.addApex(p24);

        if(detector.isOverlap(hull1, hull2))
        {
            std::cout << "Overlap" << std::endl;
        }
    }

    // test code for getIntersectionPoint()
    {
        Point p11(0.0, 0.0);
        Point p12(-1.0, -1.0);
        Point p21(0.0, -1.0);
        Point p22(-1.0, 0.0);
        Segment seg1;
        seg1.endpoint1 = p11;
        seg1.endpoint2 = p12;
        Segment seg2;
        seg2.endpoint1 = p21;
        seg2.endpoint2 = p22;
        Point intersectionPoint = detector.getIntersectionPoint(seg1, seg2);
        {
            std::cout << "Intersection point: " << intersectionPoint[0] << " " << intersectionPoint[1] << std::endl;
        }
    }

    // test code for getOverlapConvexHull
    {
        Point p11(0.0, 1.0);
        Point p12(-1.0, 0.0);
        Point p13(0.0, -1.0);
        Point p14(1.0, 0.0);
        ConvexHull hull1;
        hull1.addApex(p11);
        hull1.addApex(p12);
        hull1.addApex(p13);
        hull1.addApex(p14);

        Point shift(1.0, 0.0);
        Point p21 = p11 + shift;
        Point p22 = p12 + shift;
        Point p23 = p13 + shift;
        Point p24 = p14 + shift;
        ConvexHull hull2;
        hull2.addApex(p21);
        hull2.addApex(p22);
        hull2.addApex(p23);
        hull2.addApex(p24);

        ConvexHull overlapHull;
        overlapHull = detector.getOverlapConvexHull(hull1, hull2);
        std::cout << "Overlap hull: " << std::endl;
        for(auto i = 0; i < overlapHull.getSize(); ++i)
        {
            Point point = overlapHull.getApex(i);
            std::cout << "(" << point[0] << ", " << point[1] << ")" << std::endl;
        }

        overlapHull = detector.getOverlapConvexHull(hull2, hull1);
        std::cout << "Overlap hull: " << std::endl;
        for(auto i = 0; i < overlapHull.getSize(); ++i)
        {
            Point point = overlapHull.getApex(i);
            std::cout << "(" << point[0] << ", " << point[1] << ")" << std::endl;
        }

    }

    return 0;
}
