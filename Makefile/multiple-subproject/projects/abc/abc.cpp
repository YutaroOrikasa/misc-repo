#include "../liba/liba.hpp"
#include "../libb/libb.hpp"
#include "../libc/libc.hpp"

#include <iostream>

int main()
{
    liba::greet();
    libb::greet();
    libc::greet();
    std::cout << "abc" << std::endl;
    return 0;
}
