#include <iostream>
#include "Polynome.hpp"
#include <string>
#include <iconv.h>

using namespace std;

const string exposant[] {
  "",
  "",
  "²",
  "³",
  "⁴",
  "⁵",
  "⁶",
  "⁷",
  "⁸",
  "⁹"
};

int main() {
  iconv_t cd = iconv_open("UTF−16", "UTF−8");

  char ** blabla = {{20, 74}}, ** blabla_retour = new char[10];
  size_t taille = 1, taille_retour = 10;
  size_t retour = iconv(cd, blabla, &taille, blabla_retour, &taille_retour);

  iconv_close(cd);

  cout << blabla_retour << endl;

  return 0;
}
