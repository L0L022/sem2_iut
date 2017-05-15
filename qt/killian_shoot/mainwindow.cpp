#include "mainwindow.h"
#include "enemy.h"
#include "bullet.h"
#include <QKeyEvent>
#include <QTime>
#include <QDebug>
#include <typeinfo>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_timer(this),
      m_elapsedTime(),
      m_view(nullptr),
      m_scene(nullptr),
      m_player(nullptr),
      m_keys(Item::NONE)
{
    m_player = new Player(nullptr);

    m_scene = new QGraphicsScene(this);
    m_scene->addItem(m_player);

    m_view = new QGraphicsView(m_scene, this);
    m_view->setFocusPolicy(Qt::NoFocus);

    connect(&m_timer, &QTimer::timeout, this, &MainWindow::updateGame);

    m_timer.setInterval(1);
    m_timer.start();
    m_elapsedTime.start();

    setFocusPolicy(Qt::StrongFocus);
    setCentralWidget(m_view);

    m_scene->addItem(new Enemy());
    m_scene->addItem(new Enemy());
    m_scene->addItem(new Enemy());
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
        m_scene->addItem(new Bullet()); // add direction
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
        if (typeid(*item) == typeid(Enemy)) {
            Enemy *enemy = qgraphicsitem_cast<Enemy*>(item);
            enemy->move(Item::DOWN | Item::NONE, time);
        }
        if (typeid(*item) == typeid(Item)) {
            Item *it = qgraphicsitem_cast<Item*>(item);
            if (it->isDie()) {
                m_scene->removeItem(it);
                delete it;
            }
        }
    }
}
