#ifndef ENEMY_H
#define ENEMY_H

#include "item.h"

class Enemy : public Item
{
public:
    Enemy(QGraphicsItem *parent = nullptr);
    ~Enemy();
};

#endif // ENEMY_H
