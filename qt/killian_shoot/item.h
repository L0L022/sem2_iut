#ifndef ITEM_H
#define ITEM_H

#include <QGraphicsItem>

class Item : public QGraphicsItem
{
public:
    enum Direction {
        UP,
        DOWN,
        RIGHT,
        LEFT
    };

    Item(QGraphicsItem *parent = nullptr);
    ~Item();

    void move(const Direction dir, const quint16 elapsed);

protected:
    qreal m_speed;
};

#endif // ITEM_H
