#include "item.h"
#include <QDebug>

Item::Item(QGraphicsItem *parent)
    : QGraphicsItem(parent),
      m_speed(10)
{
}

Item::~Item()
{
}

void Item::move(const Direction dir, const quint16 elapsed)
{
    QPointF vec;

    if (dir == UP)
        vec.ry() += m_speed;
    if (dir == DOWN)
        vec.ry() -= m_speed;
    if (dir == RIGHT)
        vec.rx() += m_speed;
    if (dir == LEFT)
        vec.rx() -= m_speed;

    vec *= elapsed;
    moveBy(vec.x(), vec.y());

    qDebug() << vec << " " << elapsed;
}
