#include "player.h"

Player::Player(QGraphicsItem *parent)
    : Item(parent),
      m_pixmap(nullptr)
{
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-calculator.png");

    m_pixmap = new QGraphicsPixmapItem(pixmap, this);
}

Player::~Player()
{
}

QRectF Player::boundingRect() const
{
    return m_pixmap->boundingRect();
}

void Player::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    m_pixmap->paint(painter, option, widget);
}
