#ifndef BULLET_H
#define BULLET_H

#include "item.h"
#include <QVector2D>
#include <QTimer>

class Bullet : public Item
{
public:
    Bullet(QVector2D dir, QGraphicsItem *sender, QGraphicsItem *parent = nullptr);
    ~Bullet();

    void update(const float elapsed);
    bool isDie() const;

    int type() const;

private:
    QVector2D m_dir;
    QGraphicsItem *m_sender;
    QTimer m_timer;
};

#endif // BULLET_H
