#include <iostream>
#include "PileChar.hpp"

using namespace std;

int main() {
  cout << "On crée une pile p1 avec 100 emplacements." << endl;
  PileChar p1(100);
  cout << "On crée une autre pile p2 par défaut (avec 1024 emplacements)." << endl;
  PileChar p2;

  cout << "On empile 'A' sur p1." << endl;
  p1.empiler('A');
  cout << "On empile successivement sur p2 chaque lettre de l'alphabet." << endl;
  for(char c = 'a'; c <= 'z'; ++c)
    p2.empiler(c);

  cout << "La pile p2 contient actuellement " << p2.compter() << " lettres." << endl;

  cout << "On crée une pile p3 comme copie de la pile p2." << endl;
  PileChar p3(p2);

  cout << "On affiche et dépile successivement chaque lettre de p3 : ";
  while(p3.compter() != 0) {
    cout << p3.sommet();
    p3.depiler();
  }
  cout << endl;

  cout << "Affichage du contenu de p1 : "; p1.afficher(cout); cout << endl;
  cout << "Affichage du contenu de p2 : "; p2.afficher(cout); cout << endl;
  cout << "Affichage du contenu de p3 : "; p3.afficher(cout); cout << endl;

  return 0;
}
