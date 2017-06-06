#ifndef QDOCKMAINWINDOW_H
#define QDOCKMAINWINDOW_H

#include <QMainWindow>
#include <QVBoxLayout>
#include <QAction>

class QDockMainWindow : public QMainWindow
{
    Q_OBJECT

public:
    QDockMainWindow(QWidget *parent = 0);
    ~QDockMainWindow();

    void openProject(const QString &directory);
    void closeProject();

private:
    void addActions();
    void removeActions();
    void addCustomAction();

private:
    const QStringList m_aliases;
    const QStringList m_commands;
    QString m_commandDir;

    QVBoxLayout *m_layout;
    QAction *m_actionCloseProject;
    QAction *m_actionCustomAction;
};

#endif // QDOCKMAINWINDOW_H
