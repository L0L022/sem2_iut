#include "item.h"
#include <QVector2D>
#include <QDebug>

Item::Item(QGraphicsItem *parent)
    : QGraphicsItem(parent),
      m_speed(100),
      m_pixmap(nullptr)
{
    m_pixmap = new QGraphicsPixmapItem(this);
}

Item::~Item()
{
}

bool Item::isDie() const
{
    return false;
}

void Item::move(const Directions dir, const float elapsed)
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
    vec *= m_speed * elapsed;
    moveBy(vec.x(), vec.y());
}

QRectF Item::boundingRect() const
{
    return childrenBoundingRect();
}

void Item::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    m_pixmap->paint(painter, option, widget);
}
