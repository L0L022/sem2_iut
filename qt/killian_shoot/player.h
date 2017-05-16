#ifndef PLAYER_H
#define PLAYER_H

#include "item.h"
#include <QVector2D>

class Player : public Item
{
public:
    Player(QGraphicsItem *parent = nullptr);
    ~Player();

    void shoot();

    void move(const Directions dir, const float elapsed);
    int type() const;

private:
    QVector2D m_lastDir;
};

#endif // PLAYER_H
