#include <iostream>
#include <cmath>

using namespace std;

int main() {
  size_t nb_fois_que_ca_marche = 1;
  unsigned long int taille_marche = 1;
  unsigned long int taille_marche_pas = 1;

  while(true) {
    try {
        char * tab = new char[taille_marche_pas];
        delete tab;
        taille_marche = taille_marche_pas;
        taille_marche_pas += exp(nb_fois_que_ca_marche);
        ++nb_fois_que_ca_marche;
    } catch (const bad_alloc &e) {
      taille_marche_pas = (taille_marche_pas + taille_marche)/2;
      nb_fois_que_ca_marche = 1;
    }
    cout << "taille : " << taille_marche << " taille non : " << taille_marche_pas << " nb marche : " << nb_fois_que_ca_marche <<  endl;
  }

  return 0;
}
