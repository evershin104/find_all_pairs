import QtQuick 2.0

Image {
    id: im
    /* Открыто ли изображение */
    property bool config: false

    /* Сигнал на открытие диалогового окна в случае победы */
    signal win()

    /* Ресурс-изображение на момент иницализации поля */
    source: "/images/question.jpg"

    /* Открывает-закрывает изображение, которые было нажато */
    function show() {
        (config ? source = "/images/" + helper.toOpen(index).toString() : source = "/images/question.jpg")
    }

    width: 150
    height: 150

    MouseArea {
        id: area
        enabled: true
        anchors.fill: parent
        onClicked: {
            config = !config
            if (gameplay.clicks % 2 === 0) {
                gameplay.last_last = index
                if (timer.running) {
                    timer.stop()
                    gameplay.clearLess()
                    gameplay.hide()
                }
                show()
            }
            if (gameplay.clicks % 2 === 1) {
                gameplay.last = index
                show()
                if (gameplay.check()) {
                    if (helper.checkModel()) { win() }
                }
                timer.start()
            }
            gameplay.clicks++
        }
    }
}
