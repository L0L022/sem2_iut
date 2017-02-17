#include "Polynome.hpp"

Polynome::Polynome(const size_t degre, const double *coefs)
: _degre(degre), _coefs(nullptr) {
  _coefs = new double[_degre];
  for(size_t i = 0; i <= _degre; i++)
    _coefs[i] = coefs[i];
}

Polynome::Polynome(const Polynome &poly)
: Polynome(poly._degre, poly._coefs) {}

Polynome::~Polynome() {
  delete[] _coefs;
}

const Polynome &Polynome::operator=(const Polynome &poly) {
  delete[] _coefs;
  _degre = poly._degre;
  for(size_t i = 0; i <= _degre; i++)
    _coefs[i] = poly._coefs[i];

  return *this;
}

std::ostream &operator<<(std::ostream &out, const Polynome &poly) {
  
  return out;
}
