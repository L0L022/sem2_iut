#include "qprocessdialog.h"
#include <QVBoxLayout>

QProcessDialog::QProcessDialog(QProcess *process, QWidget *parent)
    : QDialog(parent),
      m_process(process),
      m_label(nullptr),
      m_button(nullptr)
{
    if (process == nullptr)
        throw std::runtime_error("QProcessDialog: process == nullptr");

    QVBoxLayout *layout = new QVBoxLayout;
    setLayout(layout);

    m_label = new QLabel;
    layout->addWidget(m_label);

    m_button = new QPushButton(tr("Arrêter"));
    layout->addWidget(m_button, 0, Qt::AlignRight);

    connect(m_button, &QPushButton::clicked, this, [this] {
        m_process->terminate();
        close();
    });

    connect(m_process, &QProcess::readyRead, this, [this]() {
        appendText(m_process->readAll());
    });

    connect(m_process, &QProcess::errorOccurred, this, [this](QProcess::ProcessError error) {
        appendText("\nQProcessError: " + QString::number(error));
    });

    connect(m_process, static_cast<void (QProcess::*)(int, QProcess::ExitStatus)>(&QProcess::finished), this, [this](const int exit) {
        appendText("\nProcessus terminé, code de retour: " + QString::number(exit));
        m_button->setText(tr("Fermer"));
    });
}

void QProcessDialog::appendText(const QString &text)
{
    m_label->setText(m_label->text() + text);
}
