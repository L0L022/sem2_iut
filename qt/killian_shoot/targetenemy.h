#ifndef TARGETENEMY_H
#define TARGETENEMY_H

#include "enemy.h"

class TargetEnemy : public Enemy
{
public:
    TargetEnemy(QGraphicsItem *target, QGraphicsItem *parent = nullptr);

    void update(const float elapsed);

private:
    QGraphicsItem *m_target;
};

#endif // TARGETENEMY_H
