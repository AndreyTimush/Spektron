#ifndef LISTFILES_H
#define LISTFILES_H

#include <QAbstractListModel>
#include <QStringList>

//![0]
class ListFiles : public QAbstractListModel
{
    Q_OBJECT

public:
    ListFiles(QObject *parent = 0);
    ~ListFiles();
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    void getFiles();
    QStringList fileList;
};

#endif // LISTFILES_H
