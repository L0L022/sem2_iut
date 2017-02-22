#include "Polynome.hpp"
#include <string>

Polynome::Polynome(const size_t degre, const double coefs[])
    : _degre(degre), _coefs(nullptr) {
  _coefs = new double[_degre];
  for (size_t i = 0; i <= _degre; i++)
    _coefs[i] = coefs[i];
}

Polynome::Polynome(const Polynome &poly) : Polynome(poly._degre, poly._coefs) {}

Polynome::~Polynome() { delete[] _coefs; }

Polynome &Polynome::operator=(const Polynome &poly) {
  delete[] _coefs;
  _degre = poly._degre;
  for (size_t i = 0; i <= _degre; i++)
    _coefs[i] = poly._coefs[i];

  return *this;
}

Polynome Polynome::operator+(const Polynome &poly) const {
  const size_t degre_max = std::max(degre(), poly.degre());
  double *coefs = new double[degre_max];

  for(size_t degre = 0; degre <= degre_max; ++degre) {
    if(degre <= _degre && degre <= poly.degre())
      coefs[degre] = (*this)[degre] + poly[degre];
    else if(degre <= _degre && degre > poly.degre())
      coefs[degre] = (*this)[degre];
    else if(degre > _degre && degre <= poly.degre())
      coefs[degre] = poly[degre];
  }
  return Polynome(degre_max, coefs);
}

double Polynome::operator[](const size_t index) const { return _coefs[index]; }

double Polynome::operator()(const int nb) const { return 0.0; }

size_t Polynome::degre() const { return _degre; }

const Polynome &Polynome::deriver() const { return *this; }

const std::string exposant[]{"", "", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"};

std::ostream &operator<<(std::ostream &out, const Polynome &poly) {
  for (size_t degre = poly.degre(); degre >= 1; --degre) {
    if (poly[degre] != 0) {
      if (poly[degre] == 1)
        out << "";
      else if (poly[degre] == -1)
        out << '-';
      else
        out << poly[degre];

      out << 'x' << exposant[degre];
    }
    if (poly[degre - 1] > 0)
      out << '+';
  }
  if(poly[0] != 0)
    out << poly[0] << exposant[0];
  return out;
}
