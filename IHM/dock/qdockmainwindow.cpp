#include "qdockmainwindow.h"
#include <QApplication>
#include <QMenuBar>
#include <QFileDialog>
#include <QLabel>
#include "qlaunchbutton.h"
#include "qcustomactiondialog.h"

QDockMainWindow::QDockMainWindow(QWidget *parent)
    : QMainWindow(parent),
      m_aliases({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commands({"ls -l", "qmake -project", "qmake", "make clean", "make"}),
      m_commandDir(),
      m_layout(nullptr),
      m_actionCloseProject(nullptr),
      m_actionCustomAction(nullptr)
{
    setWindowTitle(tr("Dock 2017"));
    resize(500, 300);
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
    m_actionCustomAction = menu->addAction(tr("Ajouter une commande"), this, &QDockMainWindow::addCustomAction, QKeySequence::New);
    m_actionCustomAction->setEnabled(false);
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
        m_actionCustomAction->setEnabled(true);
        addActions();
    }
}

void QDockMainWindow::closeProject()
{
    m_commandDir.clear();

    m_actionCloseProject->setEnabled(false);
    m_actionCustomAction->setEnabled(false);
    removeActions();
}

void QDockMainWindow::addActions()
{
    if (m_layout->isEmpty()) {
        m_layout->addWidget(new QLabel(tr("Projet : %1").arg(m_commandDir)));
        for (int i = 0; i < m_commands.size(); ++i)
            m_layout->addWidget(new QLaunchButton(m_aliases[i], m_commands[i], m_commandDir));
    }
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

void QDockMainWindow::addCustomAction()
{
    if (!m_layout->isEmpty()) {
        QCustomActionDialog dialog(this);
        if (dialog.exec() == QCustomActionDialog::Accepted) {
            QString dir = dialog.customDir();
            if (dir.isEmpty())
                dir = m_commandDir;
            m_layout->addWidget(new QLaunchButton(dialog.customName(), dialog.customCommand(), dir));
        }
    }
}
