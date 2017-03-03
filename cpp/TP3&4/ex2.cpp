#include <iostream>
#include "Polynome.hpp"

using namespace std;

int main() {
  char command;
  do {
    cout << ':';
    cin.get(command);
  } while(command != '.');
}
