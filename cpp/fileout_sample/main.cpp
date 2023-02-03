#include <iostream>
#include <fstream>

int main() {
    std::ofstream writing_file_new;
    std::ofstream writing_file_add;

    std::string filename_new = "fileout_sample_new.dat";
    std::string filename_add = "fileout_sample_add.dat";

    writing_file_new.open(filename_new, std::ios::out);
    writing_file_add.open(filename_add, std::ios::app);

    auto isEven = [](int num){ if(num%2==0){return 1;}else{return 0;};};
    for(auto i = 0; i < 10; ++i)
    {
        writing_file_new << i << " " << isEven(i) << std::endl;
        writing_file_add << i << " " << isEven(i) << std::endl;
    }

    writing_file_new.close();
    writing_file_add.close();
    return 0;
}
