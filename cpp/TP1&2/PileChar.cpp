#include "PileChar.hpp"
#include <stdexcept>

using namespace std;

PileChar::PileChar(const size_t _taille) : _taille(0), _taille_max(_taille), _buffer(nullptr) {
	_buffer = new char[_taille_max];
}

PileChar::PileChar(const PileChar &origine) : PileChar(origine._taille_max) {
	for(size_t i = 0; i < _taille_max; ++i)
		_buffer[i] = origine._buffer[i];
	_taille = origine._taille;
}

PileChar::~PileChar() {
	delete[] _buffer;
}

void PileChar::empiler(const char c) {
	if(_taille + 1 < _taille_max)
		_buffer[_taille++] = c;
	else
		throw runtime_error("Pille pleine !");
}

void PileChar::depiler() {
	if(_taille > 0)
		--_taille;
	else
		throw runtime_error("Pile vide");
}

char PileChar::tete() const {
	if(_taille > 0)
		return _buffer[_taille-1];
	else
		throw runtime_error("Pile vide");
}

size_t PileChar::taille() const {
	return _taille;
}

size_t PileChar::taille_buffer() const {
	return _taille_max;
}

void PileChar::afficher(ostream &out) const {
	for(size_t i = 0; i < _taille; ++i)
		out << _buffer[i];
}

char PileChar::sommet() const {
	return tete();
}

size_t PileChar::compter() const {
	return taille();
}

std::ostream& operator<<(std::ostream &out, const PileChar &pileChar) {
	out << pileChar.tete();
	return out;
}
