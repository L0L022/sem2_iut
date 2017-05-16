#include "item.h"
#include <QVector2D>
#include <QDebug>

Item::Item(QGraphicsItem *parent)
    : QGraphicsItem(parent),
      m_speed(100),
      m_pixmap(nullptr),
      m_life(1)
{
    m_pixmap = new QGraphicsPixmapItem(this);
}

Item::~Item()
{
    //qDebug() << "Item deleted: " << type();
}

void Item::update(const float elapsed)
{
    Q_UNUSED(elapsed)
}

bool Item::isDie() const
{
    return m_life <= 0;
}

void Item::move(const Directions dir, const float elapsed)
{
    QVector2D vec = dirToVector(dir);
    vec *= m_speed * elapsed;
    moveBy(vec.x(), vec.y());
}

int Item::life() const
{
    return m_life;
}

void Item::setLife(int l)
{
    m_life = l;
}

QVector2D Item::dirToVector(const Directions &dir) const
{
    QVector2D vec;
    if (dir.testFlag(UP))
        vec[1] -= 1;
    if (dir.testFlag(DOWN))
        vec[1] += 1;
    if (dir.testFlag(RIGHT))
        vec[0] += 1;
    if (dir.testFlag(LEFT))
        vec[0] -= 1;
    vec.normalize();
    return vec;
}

int Item::type() const
{
    return ItemType;
}

QRectF Item::boundingRect() const
{
    return childrenBoundingRect();
}

void Item::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    m_pixmap->paint(painter, option, widget);
}
