#include "mainwindow.h"
#include "enemy.h"
#include "targetenemy.h"
#include "randomenemy.h"
#include "bullet.h"
#include <QKeyEvent>
#include <QTime>
#include <QOpenGLWidget>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_timer(this),
      m_elapsedTime(),
      m_view(nullptr),
      m_scene(nullptr),
      m_player(nullptr),
      m_keys(Item::NONE)
{
    resize(500, 500);

    m_view = new QGraphicsView(this);
    m_view->setFocusPolicy(Qt::NoFocus);
    //m_view->setViewport(new QOpenGLWidget());

    m_scene = new QGraphicsScene(this);
    m_view->setScene(m_scene);

    m_player = new Player();
    m_scene->addItem(m_player);

    connect(&m_timer, &QTimer::timeout, this, &MainWindow::updateGame);

    m_timer.setInterval(1);
    m_timer.start();
    m_elapsedTime.start();

    setFocusPolicy(Qt::StrongFocus);
    setCentralWidget(m_view);

    for (int i = 0; i < 20; ++i) {
        Enemy *enemy = nullptr;
        if (qrand()%2 == 0)
            enemy = new TargetEnemy(m_player);
        else
            enemy = new RandomEnemy();
        m_scene->addItem(enemy);
        enemy->setPos(qrand()%600, qrand()%600);
    }
}

MainWindow::~MainWindow()
{
}

void MainWindow::keyPressEvent(QKeyEvent *event)
{   
    if (event->key() == Qt::Key_Up)
        m_keys |= Item::UP;
    if (event->key() == Qt::Key_Down)
        m_keys |= Item::DOWN;
    if(event->key() == Qt::Key_Right)
        m_keys |= Item::RIGHT;
    if (event->key() == Qt::Key_Left)
        m_keys |= Item::LEFT;

    if (event->key() == Qt::Key_Space)
        m_player->shoot();
}

void MainWindow::keyReleaseEvent(QKeyEvent *event)
{
    if (event->key() == Qt::Key_Up)
        m_keys ^= m_keys & Item::UP;
    if (event->key() == Qt::Key_Down)
        m_keys ^= m_keys & Item::DOWN;
    if (event->key() == Qt::Key_Right)
        m_keys ^= m_keys & Item::RIGHT;
    if (event->key() == Qt::Key_Left)
        m_keys ^= m_keys & Item::LEFT;
}

void MainWindow::updateGame()
{
    float time = m_elapsedTime.restart()*0.001;
    m_player->move(m_keys, time);

    for (QGraphicsItem *item : m_scene->items()) {
//        Enemy *enemy = dynamic_cast<Enemy*>(item);
//        if (enemy)
//            enemy->move(Item::DOWN, time);
        Item *it = dynamic_cast<Item*>(item);
        if (it && it->type() != Item::PlayerType) {
            it->update(time);
            if (it->isDie()) {
                m_scene->removeItem(it);
                delete it;
            }
        }
    }
    m_view->setSceneRect(QRectF(m_player->x() - width()/2.f, m_player->y() - height()/2.f, width(), height()));
    //m_view->centerOn(m_player);
}
