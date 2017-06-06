#include "qcustomactiondialog.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QFileDialog>

QCustomActionDialog::QCustomActionDialog(QWidget *parent)
    : QDialog(parent),
      m_name(nullptr),
      m_command(nullptr),
      m_dir(nullptr)
{
    setWindowTitle(tr("Ajouter un bouton d'action"));

    QVBoxLayout *layout = new QVBoxLayout;
    setLayout(layout);

    QHBoxLayout *layout1 = new QHBoxLayout;
    layout1->addWidget(new QLabel(tr("Nom :")));
    m_name = new QLineEdit;
    layout1->addWidget(m_name);
    layout->addLayout(layout1);

    QHBoxLayout *layout2 = new QHBoxLayout;
    layout2->addWidget(new QLabel(tr("Commande :")));
    m_command = new QLineEdit;
    layout2->addWidget(m_command);
    QPushButton *openCommand = new QPushButton(tr("Choisir..."));
    layout2->addWidget(openCommand);
    layout->addLayout(layout2);

    connect(openCommand, &QPushButton::clicked, this, [this]() {
        m_command->setText(QFileDialog::getOpenFileName(this));
    });

    QHBoxLayout *layout3 = new QHBoxLayout;
    layout3->addWidget(new QLabel(tr("Dossier :")));
    m_dir = new QLineEdit;
    m_dir->setPlaceholderText(tr("Laisser vide -> Dossier du projet"));
    layout3->addWidget(m_dir);
    QPushButton *openDir = new QPushButton(tr("Choisir..."));
    layout3->addWidget(openDir);
    layout->addLayout(layout3);

    connect(openDir, &QPushButton::clicked, this, [this]() {
        m_dir->setText(QFileDialog::getExistingDirectory(this));
    });

    QHBoxLayout *layout4 = new QHBoxLayout;
    QPushButton *cancel = new QPushButton(tr("Annuler"));
    layout4->addWidget(cancel);
    QPushButton *accept = new QPushButton(tr("Ok"));
    layout4->addWidget(accept);
    layout->addLayout(layout4);

    connect(cancel, &QPushButton::clicked, this, [this] {
        done(QDialog::Rejected);
    });

    connect(accept, &QPushButton::clicked, this, [this]() {
        done(QDialog::Accepted);
    });
}
