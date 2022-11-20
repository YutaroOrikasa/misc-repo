#include "../liba/liba.hpp"

#include <iostream>
namespace libreqa
{
    void greet() {
        liba::greet();
        std::cout << "libreqa" << std::endl;
    }
} // namespace libreqa
