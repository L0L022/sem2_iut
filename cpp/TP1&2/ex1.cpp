#include <iostream>
#include "PileChar.hpp"

using namespace std;

int main() {
  PileChar saisie;
  do {
    saisie.empiler('\0');
    cin.get(saisie.tete());
  } while(saisie.tete()!='.');
  saisie.depiler();
  for(; saisie.taille() > 0; saisie.depiler())
    cout << saisie.tete() << endl;
}
