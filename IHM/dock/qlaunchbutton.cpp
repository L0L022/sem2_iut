#include "qlaunchbutton.h"
#include "qprocessdialog.h"

QLaunchButton::QLaunchButton(const QString &alias, const QString &command, const QString &dir, QWidget *parent)
    : QPushButton(parent),
      m_alias(alias),
      m_command(command),
      m_dir(dir)
{
    setText(alias);

    connect(this, &QLaunchButton::clicked, this, &QLaunchButton::launch);
}

void QLaunchButton::launch()
{
    QProcess *process = new QProcess(this);

    QStringList args(m_command.split(' '));
    process->setProgram(args[0]);
    args.pop_front();
    process->setArguments(args);

    process->setWorkingDirectory(m_dir);
    process->setProcessChannelMode(QProcess::MergedChannels);

    QProcessDialog *dialog = new QProcessDialog(process, this);
    dialog->setWindowTitle(m_alias);
    dialog->open();

    process->start();
}
