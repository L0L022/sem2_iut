#include "Traceur.hpp"

void Traceur::trace_axes() {
  setColor(ez_black);
  unsigned int x0 = int((0. - xmin) / (xmax - xmin) * double(getWidth() - 0));
  unsigned int y0 = getHeight() - int((0. - ymin) / (ymax - ymin) *
                                      double(getHeight() - 0));
  if (y0 <= getHeight() - 1)
    drawLine(0, y0, getWidth() - 1, y0); // Axe des X
  if (x0 <= getWidth() - 1)
    drawLine(x0, 0, x0, getHeight() - 1); // Axe des Y
}

void Traceur::trace_fonction() {
  setColor(ez_blue);
  int ipred, jpred; // Les coordonnees du point du tour de boucle precedant.
  for (unsigned int i = 0; i < getWidth(); i += pixel_step) {
    double x =
        double(i - 0) * (xmax - xmin) / double(getWidth() - 0) +
        xmin; // On calcule le x reel correspondant a la colonne de pixel i.
    double y = (*f)(x); // On declenche la fonction *f sur la coordonnee x et
                        // on stocke la valeur dans y.

    int j;
    if (y < ymin)
      j = getWidth(); // Si y est trop petit, on force j a la ligne du bas.
    else if (y > ymax)
      j = -1; // Si y est trop grand, on force j a la ligne du haut.
    else
      j = getHeight() -
          (unsigned int)((y - ymin) * (getHeight() - 0) / (ymax - ymin) -
                         0); // On calcule le j entier correspondant a la
                             // valeur de y.

    if (i == 0)
      drawPoint(i, j); // Si c'est le premier point, on met juste un point
    else
      drawLine(ipred, jpred, i, j); // sinon on trace une ligne reliant le
                                    // point precedant au point courant.
    ipred = i;
    jpred = j; // Memorisation de i et j pour le tour suivant.
  }
}

void Traceur::trace_curseur() {
  setColor(ez_red);
  ostringstream oss;
  if (curi >= 0 && curi < int(getWidth()) && curj >= 0 &&
      curj < int(getHeight())) // Si le curseur est dans la fenetre,
  {
    double x =
        double(curi - 0) * (xmax - xmin) / double(getWidth() - 0) + xmin;
    double y =
        double(getHeight() - curj) * (ymax - ymin) / double(getHeight() - 0) +
        ymin;
    const int cursor_size = 3;
    drawRectangle(curi - cursor_size, curj - cursor_size, curi + cursor_size,
                  curj + cursor_size);
    oss << "x=" << x << " y=" << y;
  } else
    oss << "Cliquez pour mesurer une position.";
  drawText(EZAlign::BL, 3, getHeight() - 10, oss.str());
}

Traceur::Traceur(int w, int h, const char *name, Polynome *_f, double _xmin,
        double _xmax, double _ymin, double _ymax, unsigned short _pixel_step)
    : EZWindow(w, h, name), f(_f), xmin(_xmin), xmax(_xmax), ymin(_ymin),
      ymax(_ymax), pixel_step(_pixel_step), curi(-1), curj(-1) {
  setDoubleBuffer(true);
} // On active le double buffer pour limiter le scintillement de l'affichage.

void Traceur::expose() {
  clear();
  trace_axes();
  trace_curseur();
  trace_fonction();
}

void Traceur::keyPress(EZKeySym keysym) // Une touche du clavier a ete enfoncee ou relachee
{
  double xstep = (xmax - xmin) / 10.;
  double ystep = (ymax - ymin) / 10.;
  switch (keysym) {
  case EZKeySym::Escape:
  case EZKeySym::q:
    close();
    break;
  case EZKeySym::Left:
    xmin -= xstep;
    xmax -= xstep;
    sendExpose();
    break;
  case EZKeySym::Right:
    xmin += xstep;
    xmax += xstep;
    sendExpose();
    break;
  case EZKeySym::Down:
    ymin -= ystep;
    ymax -= ystep;
    sendExpose();
    break;
  case EZKeySym::Up:
    ymin += ystep;
    ymax += ystep;
    sendExpose();
    break;
  case EZKeySym::minus:
  case EZKeySym::KP_Subtract:
    xmin -= xstep;
    xmax += xstep;
    ymin -= ystep;
    ymax += ystep;
    sendExpose();
    break;
  case EZKeySym::plus:
  case EZKeySym::KP_Add:
    xmin += xstep;
    xmax -= xstep;
    ymin += ystep;
    ymax -= ystep;
    sendExpose();
    break;
    default:
      break;
  }
}

void Traceur::buttonPress(int i, int j, int /*button*/) {
  curi = i;
  curj = j;
  sendExpose();
}
void Traceur::motionNotify(int i, int j, int button) {
  if (button == 1) // Si le bouton gauche est enfonce seulement,
  {
    curi = i;
    curj = j;
    sendExpose();
  } // on met a jour l'affichage.
}
void Traceur::buttonRelease(int /*i*/, int /*j*/, int /*button*/) {
  curi = -1;
  curj = -1;
  sendExpose();
}
