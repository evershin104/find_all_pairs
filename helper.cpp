#include "helper.h"

helper::helper(QObject *parent) : QObject(parent)
{

}

void helper::newGame()
{
    /* Вектор заполнения игрового поля */
    answers = pics;
    answers.append(pics);
    /* Функция перемешивания изображений
        в хаотичном порядке */
    for (int i = 0 ; i <= (rand() % (rand() % 20)); i++) {
        std::random_shuffle(answers.begin(), answers.end());
    }
    /* После инициализации игрового поля
        состояние системы - false
        (все изображения скрыты) */
    model = {false, false, false, false, false, false,
              false, false, false, false, false, false, false,
        false, false, false, };
}

QString helper::toOpen(int index)
{
    return answers[index];
}

void helper::changeModelConfig(int index)
{
    model[index] = !model[index];
}

bool helper::checkModel()
{
    if (std::count(model.begin(), model.end(), true) == model.size()) { return true; }
    else { return false; }
}


