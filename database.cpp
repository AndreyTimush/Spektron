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
    QString strPers = "delete from person where id=";
    QString strContry = "delete from country where id=";
    strPers.append(id);
    if (query.exec(strPers))
        qDebug() << "remove was successfully";
    else
        qDebug() << "bad removing";
    strContry.append(id);
    if (query.exec(strContry)) {
        qDebug() << "remove from country excellent";
    } else {
        qDebug() << "bad remvoe from country";
    }
}

void DataBase::countries(QString id)
{
    QStringList list;
    QSqlQuery query("select * from country");
    query.exec();
    while (query.next()) {
        if (id == query.value(0).toString())
            list.append(query.value(1).toString());
    }
    emit getCountries(list);
}

void DataBase::addPerson(QString data)
{
    QStringList list = data.split(";");
    QString cntries = list[1];
    QStringList listContries = list[1].split(",");

    QStringList listFields = list[0].split(",");
    QSqlQuery query;

    query.prepare("INSERT INTO person (firstname, surname, position, address, phone, martialStatus) "
                  "VALUES (:firstname, :surname, :position, :address, :phone, :martialStatus)");
    query.bindValue(":firstname", listFields[0]);
    query.bindValue(":surname", listFields[1]);
    query.bindValue(":position", listFields[2]);
    query.bindValue(":address", listFields[3]);
    query.bindValue(":phone", listFields[4]);
    query.bindValue(":martialStatus", listFields[5]);
    if (query.exec()) {
        qDebug() << "excellent insert";
    } else {
        qDebug() << "bad";
    }

    QString maxId;

    query.exec("SELECT MAX(id) FROM person");
    while (query.next()) {
        maxId = query.value(0).toString();
    }

    for (int i = 0; i < listContries.length(); i++) {
        QSqlQuery queryCountries;
        queryCountries.prepare("INSERT INTO country (id, country) "
                               "VALUES (:id, :country)");
        queryCountries.bindValue(":id", maxId);
        queryCountries.bindValue(":country", listContries[i]);
        queryCountries.exec();
    }
}
