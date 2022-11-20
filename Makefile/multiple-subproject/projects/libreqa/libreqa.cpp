#include <iostream>
namespace libreqa
{
    int init = []() {
        std::cout << "libreqa init" << std::endl;
        return 0;
    }();
} // namespace libreqa
