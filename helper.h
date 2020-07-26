#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QVector>
#include <algorithm>

class helper : public QObject
{
    Q_OBJECT
public:
    explicit helper(QObject *parent = nullptr);
    /* Вектор с игрового поля */
    QVector<QString> answers;
private:
    /* Вектор названий изображений */
    QVector<QString> pics = {"cool_rabbit.jpg", "flower.jpg", "kitty.jpg",
                             "memories.jpg", "omg.jpg", "stitch.jpg", "virus.jpg", "wow.jpg" };
    /* Состояние модели */
    QVector<bool> model;
signals:

public slots:
    /* Инициализирует игровое поле */
    void newGame(void);
    /* Возвращает название изображения в qml сцену
        для элемента поля с индексом index */
    QString toOpen(int index);
    /* Меняет конфиг с индексом index в model */
    void changeModelConfig(int index);
    /* Проверяет, выиграл ли игрок */
    bool checkModel(void);
};

#endif // HELPER_H
