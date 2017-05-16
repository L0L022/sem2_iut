#include "player.h"
#include "bullet.h"
#include <QGraphicsScene>
#include <QDebug>

Player::Player(QGraphicsItem *parent)
    : Item(parent),
      m_lastDir(0, -1)
{
    m_speed = 500;
    m_life = 10;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-calculator.png");
    m_pixmap->setPixmap(pixmap);
}

Player::~Player()
{
}

void Player::shoot()
{
    Bullet *bullet = new Bullet(m_lastDir, this);
    scene()->addItem(bullet);
    bullet->setPos(pos());
}

void Player::move(const Directions dir, const float elapsed)
{
    Item::move(dir, elapsed);
    if (dir != NONE)
        m_lastDir = dirToVector(dir);
}

int Player::type() const
{
    return PlayerType;
}
