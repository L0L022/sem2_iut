#include <iostream>

class Polynome {
public:
  Polynome() = delete;
  Polynome(const size_t degre, const double coefs[]);
  Polynome(const Polynome &poly);
  ~Polynome();

  Polynome &operator=(const Polynome &poly);
  Polynome operator+(const Polynome &poly) const;
  double operator[](const size_t index) const;
  double operator()(const int nb) const;
  size_t degre() const;
  const Polynome &deriver() const;

private:
  size_t _degre;
  double *_coefs;
};

std::ostream &operator<<(std::ostream &out, const Polynome &poly);
