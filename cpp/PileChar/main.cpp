#include <iostream>
#include "PileChar.hpp"

using namespace std;

void affiche(const PileChar &pile) {
	cout << "pile, taille: " << pile.taille() << " taille buffer: " << pile.taille_buffer() << " buffer: " << pile << endl;
}

int main() {
	PileChar pile_0, pile_1(6666), pile_2(pile_0);

	affiche(pile_0);
	affiche(pile_1);
	affiche(pile_2);

	for(size_t i = 97; i < 123; ++i) {
		pile_0.empiler(i);
		pile_1.empiler(i);
		pile_2.empiler(i);
	}

	for(size_t i = 0; i < 20; ++i)
		pile_2.depiler();

	affiche(pile_0);
	affiche(pile_1);
	affiche(pile_2);

	cout << "pile tete: " << pile_0.tete() << " " << pile_1.tete() << " " << pile_2.tete() << endl;

	return 0;
}
