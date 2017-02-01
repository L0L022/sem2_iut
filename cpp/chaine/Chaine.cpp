#include <iostream>
#include "Chaine.hpp"

Chaine::Chaine() : taille_allouee(0), tampon(nullptr) {
}

Chaine::Chaine(const char chaine[]) : Chaine() {
  affecter(chaine);
}

Chaine::Chaine(const std::string &chaine) : Chaine() {
  affecter(chaine);
}

Chaine::Chaine(const Chaine &chaine) : Chaine() {
  affecter(chaine);
}

Chaine::~Chaine() {
  delete[] tampon;
  tampon = nullptr;
  taille_allouee = 0;
}

void Chaine::afficher() const {
  if(tampon == nullptr) return;
  for (const char *ptr = tampon; *ptr != '\0'; ++ptr)
    std::cout << *ptr;
  std::cout << std::endl; // normalement faut pas mais c'est quand même plus mieux
}

size_t Chaine::longueur() const {
  if(tampon == nullptr) return 0;
  const char *ptr = tampon;
  for (; *ptr != '\0'; ++ptr)
    ;
  return ptr - tampon;
}

void Chaine::affecter(const char chaine[]) {
  size_t taille_chaine = 0;
  for (const char *ptr = chaine; *ptr != '\0'; ++ptr)
    ++taille_chaine;
  agrandir(taille_chaine);
  char *i_tampon = tampon;
  const char *i_chaine = chaine;
  while (*i_chaine != '\0')
    *i_tampon++ = *i_chaine++;
  *i_tampon = '\0';
}

void Chaine::affecter(const std::string &chaine) {
  affecter(chaine.c_str());
}

void Chaine::affecter(const Chaine &chaine) {
  affecter(chaine.tampon);
}

void Chaine::concatenation(const Chaine &chaine) {
  agrandir(chaine.longueur());
  char *i_chaine_1 = tampon + longueur();
  char *i_chaine_2 = chaine.tampon;
  while (*i_chaine_2 != '\0')
    *i_chaine_1++ = *i_chaine_2++;
  *i_chaine_1 = '\0';
}

void Chaine::applique(char (*func)(char)) {
  for (char *ptr = tampon; *ptr != '\0'; ++ptr)
    *ptr = func(*ptr);
}

void Chaine::agrandir(const size_t taille) {
  if (taille > taille_allouee) {
    char *nv_tampon = new char[taille];
    char *i_tampon = tampon;
    char *i_nv_tampon = nv_tampon;
    while (i_tampon != nullptr && *i_tampon != '\0')
      *i_nv_tampon++ = *i_tampon++;
    *i_nv_tampon = '\0';
    delete[] tampon;
    tampon = nv_tampon;
    taille_allouee = taille;
  }
}
