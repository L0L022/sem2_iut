#include <iostream>
#include "Polynome.hpp"

using namespace std;

int main() {
  const double coef_p1[] = {3, -1.414, 3, 6, 0, 1};
  Polynome p1(5, coef_p1);
  cout << "p1(x)=" << p1 << endl;

  const double coef_p2[] = {4, -2, 3, 1, -2};
  Polynome p2(4, coef_p2);
  cout << "p2(x)=" << p2 << endl;

  cout << "Construction de p3 comme copie de p2." << endl;
  Polynome p3(p2);
  if(p2 == p3)
    cout << "p2 est égal à p3... Ce qui est rassurant pour une copie !" << endl;

  cout << "Affection de p3 à p1" << endl;
  p1 = p3;

  cout << "On affecte le coefficient du monôme de degré 1 de p3 à la constante de p3." << endl;
  p3[0] = p3[1];
  cout << "p3 est maintenant égal à p3(x)=" << p3 << endl;
  if(p2 == p3)
    cout << "p2 est égal à p3... ce qui ne devrait pas arriver !" << endl;
  else
    cout << "p2 est maintenant différent de p3 !" << endl;

  cout << "(p1+p2)(x)=" << p1+p2 << endl;

  cout << "Sachant que p1(x)=" << p1 << ", on peut calculer ses valeurs suivant celles de x : " << endl;
  for(double x = -2; x <= 2; x += 1)
    cout << "Pour p1(" << x << ")=" << p1(x) << endl;

  cout << "p2(x)=" << p2;
  Polynome p2prime(p2.deriver());
  cout << " a pour dérivée : " << endl << "p2'(x)=d/dx p2(x)=" << p2prime << endl;

  return 0;
}
