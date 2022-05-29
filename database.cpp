#include "database.h"

DataBase::DataBase(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}

QVariant DataBase::data(const QModelIndex & index, int role) const {

    // Define the column number, address, so to speak, on the role of number
    int columnId = role - Qt::UserRole - 1;
    // Create the index using the ID column
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* And with the help of already data() method of the base class
     * to take out the data table from the model
     * */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QVariantMap DataBase::get(int idx) const
{
    QVariantMap map;
    foreach(int k, roleNames().keys()) {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

QHash<int, QByteArray> DataBase::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "idPerson";
    roles[NameRole] = "name";
    roles[SurnameRole] = "surname";
    roles[PositionRole] = "position";
    roles[AddressRole] = "address";
    roles[PhoneRole] = "phone";
    roles[MartialStatusRole] = "martialStatus";
    return roles;
}


void DataBase::updateModel()
{
    this->setQuery("select * from person");
}

int DataBase::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}

void DataBase::removePerson(QString id)
{
    QSqlQuery query;
    QString str = "delete from person where id=";
    str.append(id);
    if (query.exec(str))
        qDebug() << "remove was successfully";
    else
        qDebug() << "bad removing";
}

void DataBase::countries(QString id)
{
    qDebug() << "need id = " << id;
    QStringList list;
    QSqlQuery query("select * from country");
    query.exec();
    while (query.next()) {
        if (id == query.value(0).toString())
            list.append(query.value(1).toString());
    }

    qDebug() << "list = " << list;
//    query.exec("select * from countries");

    qDebug() << "function countries";
    emit getCountries(list);
//    return list;
}
