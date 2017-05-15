#ifndef PLAYER_H
#define PLAYER_H

#include "item.h"

class Player : public Item
{
public:
    Player(QGraphicsItem *parent = nullptr);
    ~Player();

    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget = nullptr);

private:
    QGraphicsPixmapItem *m_pixmap;
};

#endif // PLAYER_H
