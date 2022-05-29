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

    // Подключаемся к базе данных

//    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setDatabaseName("Test");

    QString path = QDir::currentPath() + "/persons.db";
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");//not dbConnection
    db.setDatabaseName(path);
    db.open();
//    QSqlQuery query;
//    query.exec("create table if not exists country (id integer, country varchar(50))");
//    query.exec("insert into country (id, country) values(\"2\", \"Belarus\")");

    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    DataBase *dataBase = new DataBase();
//    dataBase->setQuery("SELECT * from person");
    engine.rootContext()->setContextProperty("dataBase", dataBase);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
