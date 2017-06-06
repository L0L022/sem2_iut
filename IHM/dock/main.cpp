#include "qdockmainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QDockMainWindow w;
    w.show();

    return a.exec();
}
