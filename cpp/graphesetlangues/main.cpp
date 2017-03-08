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
  Noeud(const char lettre, const size_t poid) : poid(poid), lettre(lettre), aine(nullptr), cadet(nullptr) {}
  bool estFeuille() const {
    return aine == nullptr and cadet == nullptr;
  }
  bool estBranche() const {
    return !estFeuille();
  }
  Noeud& getAine() {
    return *aine;
  }
  Noeud& getCadet() {
    return *cadet;
  }
  char getLettre() const {
    return lettre;
  }
  size_t getPoid() const {
    if(estBranche())
      return aine->getPoid() + cadet->getPoid();
    else
      return poid;
  }
};

int main() {
  string mot("je suis loic escales");
  string mot_unique = unique(mot.begin(), mot.end());
  vector<Noeud> noeuds;
  for(char c : mot) {
    size_t count_ = count(mot.begin(), mot.end(), c);
    noeuds.emplace_back(c, count_);
  }
}
