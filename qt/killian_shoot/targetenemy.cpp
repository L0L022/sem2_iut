#include "targetenemy.h"

TargetEnemy::TargetEnemy(QGraphicsItem *target, QGraphicsItem *parent)
    : Enemy(parent),
      m_target(target)
{
    m_speed = 40;
}

void TargetEnemy::update(const float elapsed)
{
    Enemy::update(elapsed);
    Directions dir = NONE;

    if (x() < m_target->x())
        dir |= RIGHT;
    else
        dir |= LEFT;

    if (y() < m_target->y())
        dir |= DOWN;
    else
        dir |= UP;

    move(dir, elapsed);
}
