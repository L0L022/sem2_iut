#include "bullet.h"
#include <QGraphicsScene>

Bullet::Bullet(QVector2D dir, QGraphicsItem *sender, QGraphicsItem *parent)
    : Item(parent),
      m_dir(dir),
      m_sender(sender),
      m_timer()
{
    m_dir.normalize();
    m_speed = 700;
    QPixmap pixmap("/usr/share/icons/Adwaita/48x48/apps/accessories-dictionary.png");
    m_pixmap->setPixmap(pixmap);

    m_timer.setSingleShot(true);
    m_timer.start(1000);
}

Bullet::~Bullet()
{
}

void Bullet::update(const float elapsed)
{
    QVector2D vec(m_dir);
    vec *= m_speed * elapsed;
    moveBy(vec.x(), vec.y());

    for (QGraphicsItem *item : collidingItems()) {
        Item *it = dynamic_cast<Item*>(item);
        if (it && item != m_sender && it->type() != BulletType) {
            it->setLife(it->life() - 1);
            setLife(0);
        }
    }
}

bool Bullet::isDie() const
{
    return m_timer.remainingTime() <= 0 || Item::isDie();
}

int Bullet::type() const
{
    return BulletType;
}
