#include "mainwindow.h"
#include <QKeyEvent>
#include <QTime>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_timer(this),
      m_view(nullptr),
      m_scene(nullptr),
      m_player(nullptr)
{
    m_player = new Player(nullptr);

    m_scene = new QGraphicsScene(this);
    m_scene->addItem(m_player);

    m_view = new QGraphicsView(m_scene, this);
    m_view->setFocusPolicy(Qt::NoFocus);

    connect(&m_timer, &QTimer::timeout, this, &MainWindow::updateGame);

    m_timer.setInterval(QTime(0, 0, 1/60.0).msec());
    m_timer.start();

    setFocusPolicy(Qt::StrongFocus);
    setCentralWidget(m_view);
}

MainWindow::~MainWindow()
{

}

void MainWindow::paintEvent(QPaintEvent *event)
{

}

void MainWindow::keyPressEvent(QKeyEvent *event)
{
    Item::Direction dir;

    if (event->key() == Qt::Key_Up)
        dir = Item::UP;
    if (event->key() == Qt::Key_Down)
        dir = Item::DOWN;
    if(event->key() == Qt::Key_Right)
        dir = Item::RIGHT;
    if (event->key() == Qt::Key_Left)
        dir = Item::LEFT;

    m_player->move(dir, m_timer.restart()*0.001);
}

void MainWindow::updateGame()
{

}
