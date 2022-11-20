#include <iostream>
namespace libc
{
    int init = []() {
        std::cout << "libc init" << std::endl;
        return 0;
    }();
} // namespace libc
