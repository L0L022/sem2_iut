#include <iostream>
#include "Polynome.hpp"

using namespace std;

int main() {
  const double coefs[] = {4, -2, 3, 1, -2};
  Polynome poly(4, coefs);

  cout << "poly : " << poly << endl;

  const double pos_coefs[] = {4, 2, 3, 1, 2};
  Polynome pos_poly(4, pos_coefs);

  cout << "pos_poly : " << pos_poly << endl;

  const double neg_coefs[] = {-4, -2, -3, -1, -2};
  Polynome neg_poly(4, neg_coefs);

  cout << "neg_poly : " << neg_poly << endl;

  cout << "poly + pos_poly : " << poly + pos_poly << endl;
  cout << "poly + neg_poly : " << poly + neg_poly << endl;
  cout << "pos_poly + neg_poly : " << pos_poly + neg_poly << endl;

  return 0;
}
