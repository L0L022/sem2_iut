#include "enemy.h"

Enemy::Enemy(QGraphicsItem *parent)
    : Item(parent)
{
    m_speed = 20;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-character-map.png");
    m_pixmap->setPixmap(pixmap);
}

Enemy::~Enemy()
{
}
