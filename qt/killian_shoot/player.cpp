#include "player.h"

Player::Player(QGraphicsItem *parent)
    : Item(parent)
{
    m_speed = 500;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-calculator.png");
    m_pixmap->setPixmap(pixmap);
}

Player::~Player()
{
}
