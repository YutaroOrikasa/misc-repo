#include <iostream>
namespace libb
{
    int init = []() {
        std::cout << "libb init" << std::endl;
        return 0;
    }();
} // namespace libb
