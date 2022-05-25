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
    QSqlQuery query;
    query.exec("create table if not exists person (id integer primary key, firstname varchar(20), surname varchar(30), position varchar(30), address varchar(30), phone varchar(12), martialStatus varchar(10))");
//    query.exec("insert into person (firstname, surname, position, address, phone, martialStatus) values(\"Andrey\", \"Timush\", \"developer\", \"Spb\", \"89111113245\", \"holost\")");

    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    DataBase *dataBase = new DataBase();
//    dataBase->setQuery("SELECT * from person");
    engine.rootContext()->setContextProperty("dataBase", dataBase);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
