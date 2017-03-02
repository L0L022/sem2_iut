#include <iostream>

class PileChar {
public:
	PileChar(const size_t taille = 1024);
	PileChar(const PileChar& origine);
	~PileChar();

	void empiler(const char c);
	void depiler();

	char tete() const;
	size_t taille() const;
	size_t taille_buffer() const;
	void afficher(std::ostream &out) const;

	char sommet() const;
	size_t compter() const;

private:
	size_t _taille, _taille_max;
	char *_buffer;

	friend std::ostream& operator<<(std::ostream&, const PileChar&);
};
