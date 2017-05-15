#include "bullet.h"
#include <QGraphicsScene>

Bullet::Bullet(QGraphicsItem *parent)
    : Item(parent)
{
    m_speed = 700;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-dictionary.png");
    m_pixmap->setPixmap(pixmap);
}

Bullet::~Bullet()
{
}

bool Bullet::isDie() const
{
    return isVisible();
}
