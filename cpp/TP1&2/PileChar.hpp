#include <iostream>

class PileChar {
public:
	PileChar(const size_t taille = 1024);
	PileChar(const PileChar& origine);
	~PileChar();

	void empiler(const char c);
	void depiler();

	char tete() const;
	char &tete();
	size_t taille() const;
	size_t taille_buffer() const;

private:
	size_t _taille, _taille_max;
	char *_buffer;

	friend std::ostream& operator<<(std::ostream&, const PileChar&);
};
