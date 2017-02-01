#include <iostream>
#include <string>
#include "Chaine.hpp"

using namespace std;

char enMajuscule(const char c) {
  if ('a' <= c && c <= 'z')
    return c - 32; // 'a'-'A'=32
  else
    return c;
}

int main() {
  Chaine chaine_0;
  Chaine chaine_1("char []");
  Chaine chaine_2(string("std::string"));
  Chaine chaine_3(Chaine("Chaine"));

  chaine_0.afficher();
  chaine_1.afficher();
  chaine_2.afficher();
  chaine_3.afficher();

  chaine_0.affecter("une très très très très très très très très très longue chaine !");
  chaine_0.afficher();

  chaine_1.affecter("");
  chaine_1.concatenation(Chaine("1"));
  chaine_1.concatenation(Chaine(" 2"));
  chaine_1.concatenation(Chaine(" 3"));
  chaine_1.concatenation(Chaine(" 4 : "));
  chaine_1.concatenation(chaine_3);
  chaine_1.afficher();

  chaine_2.applique(enMajuscule);
  chaine_2.afficher();

  return 0;
}
