#ifndef PLAYER_H
#define PLAYER_H

#include "item.h"

class Player : public Item
{
public:
    Player(QGraphicsItem *parent = nullptr);
    ~Player();
};

#endif // PLAYER_H
