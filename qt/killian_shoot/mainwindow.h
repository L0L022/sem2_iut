#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QElapsedTimer>
#include <QGraphicsView>
#include <QGraphicsScene>

#include "player.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

protected:
    void keyPressEvent(QKeyEvent *event);
    void keyReleaseEvent(QKeyEvent *event);

private:
    void updateGame();

    QTimer m_timer;
    QElapsedTimer m_elapsedTime;

    QGraphicsView *m_view;
    QGraphicsScene *m_scene;
    Player *m_player;
    Item::Directions m_keys;
};

#endif // MAINWINDOW_H
