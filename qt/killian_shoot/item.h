#ifndef ITEM_H
#define ITEM_H

#include <QGraphicsItem>

class Item : public QGraphicsItem
{
public:
    enum Direction {
        NONE = 0x0,
        UP = 0x1,
        DOWN = 0x2,
        RIGHT = 0x4,
        LEFT = 0x8
    };
    Q_DECLARE_FLAGS(Directions, Direction)

    Item(QGraphicsItem *parent = nullptr);
    ~Item();

    virtual bool isDie() const;
    void move(const Directions dir, const float elapsed);

    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget = nullptr);

protected:
    qreal m_speed;
    QGraphicsPixmapItem *m_pixmap;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(Item::Directions)

#endif // ITEM_H
