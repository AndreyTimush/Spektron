#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include <QDir>
#include <QSqlQuery>
#include <QSqlError>

#include "database.h"
#include "listfiles.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    DataBase *dataBase = new DataBase();
    ListFiles *listFilesModel = new ListFiles();

    engine.rootContext()->setContextProperty("dataBase", dataBase);
    engine.rootContext()->setContextProperty("listFilesModel", listFilesModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
//qabsrtactlistmodel
