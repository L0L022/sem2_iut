#ifndef RANDOMENEMY_H
#define RANDOMENEMY_H

#include "enemy.h"

class RandomEnemy : public Enemy
{
public:
    RandomEnemy(QGraphicsItem *parent = nullptr);

    void update(const float elapsed);

private:
    Directions m_lastDir;
    float m_elapsedTime;
};

#endif // RANDOMENEMY_H
