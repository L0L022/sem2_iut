#ifndef QPROCESSDIALOG_H
#define QPROCESSDIALOG_H

#include <QDialog>
#include <QProcess>
#include <QLabel>
#include <QPushButton>

class QProcessDialog : public QDialog
{
    Q_OBJECT
public:
    explicit QProcessDialog(QProcess *process, QWidget *parent = nullptr);

private:
    void appendText(const QString &text);

private:
    QProcess *m_process;
    QLabel *m_label;
    QPushButton *m_button;
};

#endif // QPROCESSDIALOG_H
