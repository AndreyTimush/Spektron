#include "listfiles.h"

#include <QGuiApplication>
#include <QDir>
#include <QDebug>

ListFiles::ListFiles(QObject *parent) :
    QAbstractListModel(parent)
{
    getFiles();
}

ListFiles::~ListFiles()
{

}

void ListFiles::getFiles()
{
    QDir dir("/home/andrey/test/");
    fileList = dir.entryList(QDir::Files);
}

int ListFiles::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return fileList.count();
}

QVariant ListFiles::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= fileList.count()) {
        return QVariant();
    }

    switch (role) {
    case Qt::DisplayRole:
        return fileList.value(row);
    }

    return QVariant();
}
