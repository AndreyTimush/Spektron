#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlQueryModel>
#include <QDebug>
#include <QSqlQuery>
#include <QStandardPaths>
#include <QDir>
#include <QSqlQuery>
#include <QSqlError>

class DataBase : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = nullptr);

    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        SurnameRole,
        PositionRole,
        AddressRole,
        PhoneRole,
        MartialStatusRole
    };

    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE QVariantMap get(int idx) const;

signals:
    void getCountries(QStringList name);
    void sendInfoPerson(QStringList list);
    void sendCountries(QStringList listCountries);

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel();
    int getId(int row);
    void removePerson(QString id);
    void countries(QString id);
    void addPerson(QString data);
    void getPerson(QString id);
    void saveChanges(QString data);
};

#endif // DATABASE_H
