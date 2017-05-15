#ifndef BULLET_H
#define BULLET_H

#include "item.h"

class Bullet : public Item
{
public:
    Bullet(QGraphicsItem *parent = nullptr); // add direction
    ~Bullet();

    bool isDie() const;
};

#endif // BULLET_H
