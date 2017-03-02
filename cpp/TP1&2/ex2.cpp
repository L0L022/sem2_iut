#include <iostream>
#include <fstream>
#include <string>
#include "PileChar.hpp"

using namespace std;

string verifie(istream &input) {
  PileChar pile;
  char c;
  size_t nb_ligne = 1;
  bool no_problem = true;
  do {
    input.get(c);
    switch(c) {
      case '{':
      case '(':
      case '[':
        pile.empiler(c);
        break;
      case '}':
        if(pile.taille() > 0 && pile.tete() == '{')
          pile.depiler();
        else
          no_problem = false;
        break;
      case ')':
        if(pile.taille() > 0 && pile.tete() == '(')
          pile.depiler();
        else
          no_problem = false;
        break;
      case ']':
        if(pile.taille() > 0 && pile.tete() == '[')
          pile.depiler();
        else
          no_problem = false;
        break;
      case '\n':
        ++nb_ligne;
        break;
    }
  } while(input.good() && no_problem);

  string retour("ok");
  if(!no_problem) {
    string balise_ouvrante;
    if(pile.taille() > 0)
      balise_ouvrante = pile.tete();
    else
      balise_ouvrante = "inexistante";

    retour = string("balise ouvrante : ") + balise_ouvrante
            + string(" balise fermante : ") + c
            + string(" à la ligne : ") + to_string(nb_ligne);
  } else if(pile.taille() > 0) {
    retour = string("balise ouvrante : ") + pile.tete()
            + string(" balise fermante : inexistante")
            + string(" à la ligne : ") + to_string(nb_ligne);
  }

  return retour;
}

int main(int argc, char const *argv[]) {
  string filename("cmake_install.cmake");
  if(argc > 1)
    filename = argv[1];

  ifstream fichier(filename);
  if(!fichier)
    cout << "fichier invalide" << endl;
  else
    cout << verifie(fichier) << endl;

  return 0;
}
