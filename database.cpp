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
    query.exec("create table if not exists person (id integer primary key, firstname varchar(20), surname varchar(30), position varchar(30), address varchar(30), phone varchar(12), martialStatus varchar(10))");

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

    query.exec("create table if not exists country (id integer, country varchar(50))");
    for (int i = 0; i < listContries.length(); i++) {
        QSqlQuery queryCountries;
        queryCountries.prepare("INSERT INTO country (id, country) "
                               "VALUES (:id, :country)");
        queryCountries.bindValue(":id", maxId);
        queryCountries.bindValue(":country", listContries[i]);
        queryCountries.exec();
    }
}

void DataBase::getPerson(QString id)
{
    qDebug() << "id = " << id;
    QSqlQuery query;
    QString str = "SELECT * FROM person WHERE id=";
    str.append(id);
    query.exec(str);
    QString result = "";
    while (query.next()) {
        qDebug() << "field = " << query.value(1).toString();
        result += query.value(1).toString() + "," + query.value(2).toString() + "," + query.value(3).toString() + "," + query.value(4).toString() + "," + query.value(5).toString() + "," + query.value(6).toString();
    }
    qDebug() << "result = " << result;
//    result += ""; //можно сделать сплит ; и отделить страны от остальных полей)
    QString strCountries = "SELECT country FROM country WHERE id=";
    strCountries.append(id);
    if (query.exec(strCountries)) {
        qDebug() << "excellent";
    } else {
        qDebug() << "bad";
    }
    QString countries;
    while (query.next()) {
        countries += query.value(0).toString() + ",";
        qDebug() << query.value(0).toString();
    }
    QStringList list = result.split(",");
    QStringList listCountries = countries.split(",");
    listCountries.removeAt(listCountries.length() - 1);
    emit sendInfoPerson(list);
    emit sendCountries(listCountries);
}

void DataBase::saveChanges(QString data)
{
    qDebug() << "data = " << data;
}
