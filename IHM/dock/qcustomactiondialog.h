#ifndef QCUSTOMACTIONDIALOG_H
#define QCUSTOMACTIONDIALOG_H

#include <QDialog>
#include <QLineEdit>

class QCustomActionDialog : public QDialog
{
    Q_OBJECT
public:
    explicit QCustomActionDialog(QWidget *parent = 0);

    inline QString customName() const { return m_name->text(); }
    inline QString customCommand() const { return m_command->text(); }
    inline QString customDir() const { return m_dir->text(); }

private:
    QLineEdit *m_name, *m_command, *m_dir;
};

#endif // QCUSTOMACTIONDIALOG_H
