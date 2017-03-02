#include <iostream>
#include "PileChar.hpp"

using namespace std;

void afficher(PileChar &pile) {
  for(; pile.taille() >= 1; pile.depiler())
    cout << pile;
  cout << endl;
}

void inverse() {
  PileChar saisie;

  char c;
  do {
    cin.get(c);
    if(c != '\n')
      saisie.empiler(c);
  } while(c != '.');
  saisie.depiler();

  afficher(saisie);
}

void chiffre() {
  PileChar saisie;

  char c[2] = {'\0', '\0'};
  do {
    cin.get(c[0]);
    if(c[0] != '\n') {
      if(c[1] == '\0')
        c[1] = c[0];
      else {
        saisie.empiler(c[0]);
        saisie.empiler(c[1]);
        c[1]='\0';
      }
    }
  } while(c[0] != '.');
  saisie.depiler();

  afficher(saisie);
}

int main() {
  chiffre();
  return 0;
}
