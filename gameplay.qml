import QtQuick 2.12
import QtQuick.Layouts 1.12

GridLayout {
    width: 600
    height: 600

    id: gl
    columns: 4
    rows: 4

    columnSpacing: 0
    rowSpacing: 0

    /* Количество кликов на поле.
      Введено для проверки открытых изображений на
      соответствие (Для создания
      цикла в Unknown.qml. Проверка каждые 2 клика */
    property int clicks: 0

    /* Запоминаем индексы двух последних открытых изображений */
    property int last: 0
    property int last_last: 0

    /* Установить таймер */
    signal setTimer()

    /* Сигнал на открытие диалогового окна в случае победы */
    signal winDialog()

    /* Инициализируем новую игру */
    function newGame() {
        /* Заполняем вектор состояния модели
            и определяем индексы изображений */
        helper.newGame()
        for (var i = 0; i <= 15; i++) {
            unknowns.itemAt(i).enabled = true
        }
        clear()
        setTimer()
        clicks = 0
    }

    /* Закрывает не парные изображение при попытке
      открыть следующее нечётное изображение */
    function clear() {
        for (var i = 0; i <= 15; i++) {
            if (unknowns.itemAt(i).enabled === true) {
                unknowns.itemAt(i).source = "/images/question.jpg"
                unknowns.itemAt(i).config = false
            }
        }
    }

    /* Очищает игровое от двух непарных изображений
        в случае, если пользователь откроет третье до того,
        как пройдет время на таймере (timer) */
    function clearLess() {
        for (var i = 0; i <= 15; i++) {
            if ((unknowns.itemAt(i).enabled === true) && (i !== last_last)) {
                unknowns.itemAt(i).source = "/images/question.jpg"
                unknowns.itemAt(i).config = false
            }
        }
    }

    /* Проверяет изображения на совпадения.
       Добавляет данные о парах изображений в
      класс helper (private model) */
    function check() {
        if (last === last_last) { return false}
            if (helper.toOpen(last).toString() === helper.toOpen(last_last).toString()
                    && last.valueOf() !== last_last.valueOf()) {
                unknowns.itemAt(last).enabled = false
                unknowns.itemAt(last_last).enabled = false
                helper.changeModelConfig(last)
                helper.changeModelConfig(last_last)
                return true
            }
            return false
    }

    /* Убирает парные картинки, заменяя их на pair.jpg */
    function hide() {
        for (var i = 0; i <= 15; i++) {
            if (unknowns.itemAt(i).enabled === false) { unknowns.itemAt(i).source = "/images/pair.jpg" }
        }
    }

    /* Внутриигровой таймер на половину секунды.
      В случае открытия двух не парных изображений-
      закрывает их после 0.5 сек. */
    Timer {
        id: timer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            clear()
            hide()
        }
    }

    Repeater {
        id: unknowns
        model: 16
        Unknown {
            onWin: winDialog()
        }

        Component.onCompleted: {
            newGame()
        }
    }
}
