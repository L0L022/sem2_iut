#include <iostream>
#include "Polynome.hpp"
#include "Traceur.hpp"

using namespace std;

EZDraw application;

int main(int /*argc*/, char * /*argv*/ []) {
  cout << "Traceur de fonctions - E. Remy - 04/2010" << endl
       << "Vous pouvez vous deplacer avec les fleches et zoomer/dezoomer avec "
          "+ et -."
       << endl
       << "Vous pouvez egalement cliquer dans la fenetre pour observer les "
          "coordonnees."
       << endl;

  const double coef_p1[] = {3, -1.414, 3, 6, 0, 1};
  Polynome p1(5, coef_p1);
  Traceur wp1(640, 480, p1.formule_ascii().c_str(), &p1, -10, 10, -10, 10, 3);

  const double coef_p2[] = {4, -2, 3, 1, -2};
  Polynome p2(4, coef_p2);
  Traceur wp2(640, 480, p2.formule_ascii().c_str(), &p2, -10, 10, -10, 10, 3);

  application.mainLoop();

  return 0;
}
