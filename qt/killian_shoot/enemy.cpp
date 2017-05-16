#include "enemy.h"

Enemy::Enemy(QGraphicsItem *parent)
    : Item(parent)
{
    m_speed = 20;
    m_life = qrand()%3+1;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-character-map.png");
    m_pixmap->setPixmap(pixmap);
}

Enemy::~Enemy()
{
}

int Enemy::type() const
{
    return EnemyType;
}
