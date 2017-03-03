#include <iostream>
#include "Polynome.hpp"
#include "ez-draw++.h"

using namespace std;

int main() {
  Polynome *polynomes = new Polynome[]
  char command;
  do {
    cout << ':';
    cin.get(command);
  } while(command != '.');

  return 0;
}
