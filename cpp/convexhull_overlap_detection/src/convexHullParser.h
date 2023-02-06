#ifndef SRC_CONVEXHULLPARSER_H_
#define SRC_CONVEXHULLPARSER_H_

#include <iostream>
#include <fstream>
#include <string>
#include <memory>
#include <map>
#include <nlohmann/json.hpp>
using json = nlohmann::json;

#include "convexHull.h"

namespace overlap_detector {

// A class to parse a json file to a ConvexHull data
// or save a ConvexHull data to a json file
class ConvexHullParser {
 public:
    explicit ConvexHullParser
      (const std::shared_ptr<ConvexHullMap>& convexHullMap);
    virtual ~ConvexHullParser() {}
    bool parse(const std::string& jsonFilePath);
    bool save(const std::string& jsonFilePath);
 private:
    std::shared_ptr<ConvexHullMap> convex_hull_map_;
};
}  // namespace overlap_detector

#endif  // SRC_CONVEXHULLPARSER_H_
