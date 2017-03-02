#include <iostream>
#include "PileChar.hpp"

using namespace std;

void afficher_inverse(PileChar &pile) {
  for(; pile.taille() > 0; pile.depiler())
    cout << pile;
  cout << endl;
}

void afficher_chiffre(PileChar &pile) {
  char c;
  for(; pile.taille() > 0; pile.depiler()) {
    if(pile.taille() > 2) {
      c = pile.tete();
      pile.depiler();
      cout << pile.tete() << c;
    } else {
      cout << pile.tete();
    }
  }
  cout << endl;
}

int main() {
  PileChar saisie;

  char c;
  do {
    cin.get(c);
    if(c != '\n')
      saisie.empiler(c);
  } while(c != '.');
  saisie.depiler();

  PileChar saisie_copie(saisie);

  cout << "inverse :" << endl;
  afficher_inverse(saisie);
  cout << "chiffre :" << endl;
  afficher_chiffre(saisie_copie);

  return 0;
}
