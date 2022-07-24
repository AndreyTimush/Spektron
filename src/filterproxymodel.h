#ifndef FILTERPROXYMODEL_H
#define FILTERPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

class FilterProxyModel: public QSortFilterProxyModel
{
    Q_OBJECT
public:
    FilterProxyModel(QObject* parent = 0);
    ~FilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);
    Q_INVOKABLE void setSortOrder(bool checked);
};

#endif // FILTERPROXYMODEL_H
