#include <string>

class Chaine {
public:
  Chaine();
  Chaine(const char chaine[]);
  Chaine(const std::string &chaine);
  Chaine(const Chaine &chaine);
  ~Chaine();

  void afficher() const;
  size_t longueur() const;

  void affecter(const char chaine[]);
  void affecter(const std::string &chaine);
  void affecter(const Chaine &chaine);

  void concatenation(const Chaine &chaine);
  void applique(char (*func)(char));

private:
  void agrandir(const size_t taille);

private:
  size_t taille_allouee;
  char *tampon;
};
