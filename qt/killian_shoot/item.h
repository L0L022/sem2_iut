#ifndef ITEM_H
#define ITEM_H

#include <QGraphicsItem>

class Item : public QGraphicsItem
{
public:
    enum Types {
        ItemType = UserType + 1,
        PlayerType,
        BulletType,
        EnemyType
    };

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

    //virtual void handleCollision(GraphicsItem *item) = 0;
    virtual void update(const float elapsed);
    virtual bool isDie() const;
    virtual void move(const Directions dir, const float elapsed);

    int life() const;
    void setLife(int l);

    QVector2D dirToVector(const Directions &dir) const;

    int type() const;
    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget = nullptr);

protected:
    qreal m_speed;
    QGraphicsPixmapItem *m_pixmap;
    int m_life;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(Item::Directions)

#endif // ITEM_H
