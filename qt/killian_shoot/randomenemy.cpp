#include "randomenemy.h"

RandomEnemy::RandomEnemy(QGraphicsItem *parent)
    : Enemy(parent),
      m_lastDir(NONE),
      m_elapsedTime(0)
{
    m_speed = 80;
}

void RandomEnemy::update(const float elapsed)
{
    m_elapsedTime += elapsed;
    if (m_elapsedTime > 4) {
        m_elapsedTime = 0;
        switch (qrand()%5) {
        case 0:
            m_lastDir = NONE;
            break;
        case 1:
            m_lastDir = UP;
            break;
        case 2:
            m_lastDir = DOWN;
            break;
        case 3:
            m_lastDir = RIGHT;
            break;
        case 4:
            m_lastDir = LEFT;
            break;
        default:
            m_lastDir = NONE;
            break;
        }
    }
    move(m_lastDir, elapsed);
}
