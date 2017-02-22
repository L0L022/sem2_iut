#include <iostream>

class Polynome {
public:
  Polynome() = delete;
  Polynome(const size_t degre, const double *coefs);
  Polynome(const Polynome &poly);
  ~Polynome();

  const Polynome& operator=(const Polynome &poly);
  const Polynome& operator+(const Polynome &poly) const;
  double operator[](const int index) const;
  double operator()(const int nb) const;
  const Polynome& deriver() const;

private:
  size_t _degre;
  double *_coefs;
};
