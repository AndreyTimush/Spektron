#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlQueryModel>

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

//    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
signals:

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel();
    int getId(int row);
};

#endif // DATABASE_H
