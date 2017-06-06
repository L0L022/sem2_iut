#include "qdockmainwindow.h"
#include <QApplication>
#include <QMenuBar>
#include <QFileDialog>

QDockMainWindow::QDockMainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_aliases({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commands({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commandDir(),
      m_layout(nullptr),
      m_actionCloseProject(nullptr)
{
    m_layout = new QVBoxLayout;
    setLayout(m_layout);

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
    }
}

void QDockMainWindow::closeProject()
{
    m_commandDir.clear();
    m_actionCloseProject->setEnabled(false);
}
