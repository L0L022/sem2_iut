#ifndef __SUPERPOLYNOME__
#define __SUPERPOLYNOME__

#include <iostream>
#include <string>

class Polynome {
public:
  Polynome() = delete;
  Polynome(const size_t degre, const double coefs[]);
  Polynome(const Polynome &poly);
  ~Polynome();

  Polynome &operator=(const Polynome &poly);
  Polynome operator+(const Polynome &poly) const;
  double &operator[](const size_t index);
  double operator[](const size_t index) const;
  double operator()(const double nb) const;
  size_t degre() const;
  Polynome deriver() const;
  std::string formule_utf8() const;
  std::string formule_ascii() const;

private:
  std::string formule(const std::string exposants[]) const;

  size_t _degre;
  double *_coefs;
  static const std::string _exposant_utf8[], _exposant_ascii[];
};

std::ostream &operator<<(std::ostream &out, const Polynome &poly);
bool operator==(const Polynome &p1, const Polynome &p2);

#endif
