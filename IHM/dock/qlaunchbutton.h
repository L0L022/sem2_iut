#ifndef QLAUNCHBUTTON_H
#define QLAUNCHBUTTON_H

#include <QPushButton>

class QLaunchButton : public QPushButton
{
    Q_OBJECT
public:
    explicit QLaunchButton(const QString &alias, const QString &command, const QString &dir, QWidget *parent = nullptr);

    void launch();

private:
    QString m_alias;
    QString m_command;
    QString m_dir;
};

#endif // QLAUNCHBUTTON_H
