#include "qdockmainwindow.h"
#include <QApplication>
#include <QMenuBar>
#include <QFileDialog>
#include "qlaunchbutton.h"

#include <QDebug>

QDockMainWindow::QDockMainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_aliases({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commands({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commandDir(),
      m_layout(nullptr),
      m_actionCloseProject(nullptr)
{
    setCentralWidget(new QWidget);

    m_layout = new QVBoxLayout;
    centralWidget()->setLayout(m_layout);

    QMenu *menu = menuBar()->addMenu(tr("Projet Qt"));
    menu->addAction(tr("Ouvrir"), [this](){
        openProject(QFileDialog::getExistingDirectory(this));
    }, QKeySequence::Open);
    m_actionCloseProject = menu->addAction(tr("Fermer"), this, &QDockMainWindow::closeProject, QKeySequence::Close);
    m_actionCloseProject->setEnabled(false);
    menu->addSeparator();
    menu->addAction(tr("Quitter"), qApp, &QApplication::quit, QKeySequence::Quit);
}

QDockMainWindow::~QDockMainWindow()
{}

void QDockMainWindow::openProject(const QString &directory)
{
    QDir dir(directory);
    if (dir.exists(), dir.isReadable()) {
        m_commandDir = dir.absolutePath();

        m_actionCloseProject->setEnabled(true);
        addActions();
    }
}

void QDockMainWindow::closeProject()
{
    m_commandDir.clear();

    m_actionCloseProject->setEnabled(false);
    removeActions();
}

void QDockMainWindow::addActions()
{
    if (m_layout->isEmpty())
        for (int i = 0; i < m_commands.size(); ++i)
            m_layout->addWidget(new QLaunchButton(m_aliases[i], m_commands[i], m_commandDir, this));
}

void QDockMainWindow::removeActions()
{
    QLayoutItem *item;
    while ((item = m_layout->takeAt(0))) {
        QWidget *widget = item->widget();
        m_layout->removeItem(item);
        if (widget)
            delete widget;
    }
}
