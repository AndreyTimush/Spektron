#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include <QDir>
#include <QSqlQuery>
#include <QSqlError>

#include "database.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    DataBase *dataBase = new DataBase();
//    dataBase->setQuery("SELECT * from person");
    engine.rootContext()->setContextProperty("dataBase", dataBase);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
