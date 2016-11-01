//'sample.cpp' pythonified!
#include <iostream>

// Forward declare main
int main()                                                                                          ;

void func()                                                                                         {
    // Just call the main function again
    main()                                                                                          ;
    // This statement is never reached
    std::cout << "exiting" << std::endl                                                             ;}

int main()                                                                                          {
    // HELLO {
    func()                                                                                          ;
    if (1)                                                                                          {
        int x = 0;                                                                                  };
    return 0                                                                                        ;}
