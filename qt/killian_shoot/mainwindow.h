#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
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
    void paintEvent(QPaintEvent *event);
    void keyPressEvent(QKeyEvent *event);

private:
    void updateGame();

    QTimer m_timer;

    QGraphicsView *m_view;
    QGraphicsScene *m_scene;
    Player *m_player;
};

#endif // MAINWINDOW_H
