#ifndef __SUPERTRACEUR__
#define __SUPERTRACEUR__

#include "../ez-lib/ez-draw++.hpp"
#include <iostream>
#include <sstream>
#include "Polynome.hpp"

using namespace std;

//Code du prof un peu modifié pour que ça marche

class Traceur : public EZWindow {
  Polynome *f;
  double xmin, xmax, ymin,
      ymax; // Les valeurs minimum et maximum de la fenetre de visibilite.
  unsigned short pixel_step; // On tracera la fonction avec un point tous les
                             // pixel_step pixels.
  int curi, curj;            // Les coordonnees du curseur d'exploration

  void trace_axes();

  void trace_fonction();

  void trace_curseur();

public:
  Traceur(int w, int h, const char *name, Polynome *_f, double _xmin,
          double _xmax, double _ymin, double _ymax, unsigned short _pixel_step);

  void expose();

  void keyPress(EZKeySym keysym);

  void buttonPress(int i, int j, int /*button*/);
  void motionNotify(int i, int j, int button);
  void buttonRelease(int /*i*/, int /*j*/, int /*button*/);
};

#endif
