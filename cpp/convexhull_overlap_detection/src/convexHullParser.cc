#include "convexHullParser.h"

namespace overlap_detector {

ConvexHullParser::ConvexHullParser
    (const std::shared_ptr<ConvexHullMap>& convex_hull_map)
    : convex_hull_map_(convex_hull_map) {
}

bool ConvexHullParser::parse(const std::string& jsonfile_path) {
    std::ifstream inputfile(jsonfile_path);
    json data;
    try {
        data = json::parse(inputfile);
    }
    catch (json::parse_error& ex) {
        std::cerr << "Parse error. Error id: " << ex.id << std::endl;
    }
    if (data.empty()) return false;

    for (const auto& chulls : data["convex hulls"]) {
        ConvexHull convex_hull;
        for (const auto& apex : chulls["apexes"]) {
            Point apex_point(apex["x"], apex["y"]);
            convex_hull.addApex(apex_point);
        }
        convex_hull_map_->insert
            (ConvexHullMap::value_type(chulls["ID"], convex_hull));
    }
    return true;
}

bool ConvexHullParser::save(const std::string& jsonFilePath) {
    // create an empty json object
    json output_json;

    // setup json file based on an input convexHullMap data
    for (const auto& it : *convex_hull_map_) {
        json convex_hull_json;
        convex_hull_json["ID"] = it.first;
        ConvexHull convex_hull = it.second;
        for (unsigned int i = 0; i < convex_hull.getSize(); ++i) {
            Point point = convex_hull.getApex(i);

            json point_json;
            point_json["x"] = point[0];
            point_json["y"] = point[1];
            convex_hull_json["apexes"].push_back(point_json);
        }
        output_json["convex hulls"].push_back(convex_hull_json);
    }

    // write json file
    std::ofstream outputFile(jsonFilePath);
    if (outputFile.is_open()) {
        outputFile << std::setw(3) << output_json << std::endl;
        return true;
    }
    return false;
}

}  // namespace overlap_detector
