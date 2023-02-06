#include <iostream>
#include <memory>
#include "convexHull.h"
#include "convexHullParser.h"
#include "convexHullOverlapDetector.h"

int main() {
    // parameters
    std::string input_jsonfile_path = "../data/convex_hulls.json";
    std::string output_jsonfile_path = "../data/result_convex_hulls.json";
    double overlap_rate_threshold = 0.5;

    // the convex hull data to be loaded, edited, then saved
    std::shared_ptr<overlap_detector::ConvexHullMap> convex_hull_map
        = std::make_shared<overlap_detector::ConvexHullMap>();

    // setup a convex hull parser
    overlap_detector::ConvexHullParser parser(convex_hull_map);
    if (!parser.parse(input_jsonfile_path)) {
        std::cout << "JSON file parsing failed. convex_hulls.json might be missing." << std::endl;
        return -1;
    }

    // detect & eliminate overlapped convex hulls
    // (while checking its overlap rate)
    overlap_detector::ConvexHullOverlapDetector detector(convex_hull_map,
                                                        overlap_rate_threshold);
    detector.eliminate();

    // save updated convex hull data to a new json file
    if (!parser.save(output_jsonfile_path)) {
        std::cout << "JSON file open failed. An output file path might be invalid." << std::endl;
        return -1;
    }

    return 0;
}
