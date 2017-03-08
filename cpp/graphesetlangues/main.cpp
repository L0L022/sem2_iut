#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
using namespace std;

class Noeud {
  size_t poid;
  char lettre;
  Noeud *aine, *cadet;
public:
  Noeud(const char lettre = '\0', const size_t poid = 0) : poid(poid), lettre(lettre), aine(nullptr), cadet(nullptr) {}
  Noeud(const Noeud &noeud) : Noeud(noeud.lettre, noeud.poid) {
    if(noeud.aine != nullptr)
      aine = new Noeud(*noeud.aine);
    if(noeud.cadet != nullptr)
      cadet = new Noeud(*noeud.cadet);
  }
  ~Noeud() {
    delete aine;
    delete cadet;
  }
  Noeud &operator=(const Noeud &noeud) {
    poid = noeud.poid;
    lettre = noeud.lettre;
    delete aine;
    aine = nullptr;
    delete cadet;
    cadet = nullptr;
    if(noeud.aine != nullptr)
      aine = new Noeud(*noeud.aine);
    if(noeud.cadet != nullptr)
      cadet = new Noeud(*noeud.cadet);
    return *this;
  }
  bool estFeuille() const {
    return aine == nullptr and cadet == nullptr;
  }
  bool estBranche() const {
    return aine != nullptr and cadet != nullptr;
  }
  void setFils(const Noeud &_aine, const Noeud &_cadet) {
    delete aine;
    aine = nullptr;
    delete cadet;
    cadet = nullptr;
    aine = new Noeud(_aine);
    cadet = new Noeud(_cadet);
  }
  Noeud& getAine() const {
    return *aine;
  }
  Noeud& getCadet() const {
    return *cadet;
  }
  char getLettre() const {
    //if(estBranche()) throw runtime_error("getLettre sur une branche");
    return lettre;
  }
  size_t getPoid() const {
    if(estBranche()) {
      return aine->getPoid() + cadet->getPoid();
    }
    else
      return poid;
  }
};

bool operator<(const Noeud &noeud1, const Noeud &noeud2) {
  return noeud1.getPoid() < noeud2.getPoid();
}

ostream &operator<<(ostream &out, const Noeud &n) {
  //out << "noeud " << n.getLettre() << " poid " << n.getPoid() << " branche " << n.estBranche() << endl;
  out << n.getPoid();
  if(n.estFeuille())
    out << n.getLettre();
  out << endl;
  return out;
}

void afficher(const Noeud &n, string &profondeur) {
  cout << profondeur << n;
  if(n.estBranche()) {
    profondeur += '\t';
    afficher(n.getAine(), profondeur);
    afficher(n.getCadet(), profondeur);
    profondeur.pop_back();
  }
}

int main() {
  string mot("this is an example of a huffman tree");

  string mot_unique(mot);
  sort(mot_unique.begin(), mot_unique.end());
  mot_unique.erase(unique(mot_unique.begin(), mot_unique.end()), mot_unique.end());
  cout << mot_unique << endl;
  vector<Noeud> noeuds;
  for(char c : mot_unique) {
    size_t count_ = count(mot.begin(), mot.end(), c);
    noeuds.emplace_back(c, count_);
  }

  while(noeuds.size() > 1) {
    sort(noeuds.begin(), noeuds.end());
    Noeud nouveau_noeud;
    nouveau_noeud.setFils(noeuds[0], noeuds[1]);
    noeuds.erase(noeuds.begin());
    noeuds.erase(noeuds.begin());
    noeuds.insert(noeuds.begin(), nouveau_noeud);
  }

  for(const Noeud &n : noeuds)
    cout << "lettre: " << n.getLettre() << " poid: " << n.getPoid() << endl;

  string pro;
  afficher(noeuds[0], pro);
}
