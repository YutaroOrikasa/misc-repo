#include <iostream>
namespace liba
{
    int init = []() {
        std::cout << "liba init" << std::endl;
        return 0;
    }();
} // namespace liba
