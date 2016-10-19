#include <iostream>
#include <thread>

// Forward declare main
int main();

void bomb()
{
    // Just call the main function again
    main();
    // This statement is never reached
    std::cout << "exiting" << std::endl;
}

int main()
{
    // Spawn 2 threads
    std::thread first(bomb);
    std::thread second(bomb);
    // Wait for threads to finish (they never do)
    first.join();
    second.join();
    return 0;
}
