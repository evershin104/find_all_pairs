import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    id: rl
    property int time: 45
    signal newGame()
    signal quitApp()

    /* Сигнал на открытие диалогового окна в случае проигрыша */
    signal loseDialog()

    /* Остановка таймера */
    function stopTime() {
        timer.stop()
    }

    /* Функция вывода времени таймера в формате мм:сс */
    function timeToSet(time){
        var toRet = "Time to the end: " + "0" +
                /* Запись мм:сс */
                Math.floor(time / 60).toString() + ":" + ( (time % 60) / 10 >= 1 ? (time % 60).toString() : "0" +  (time % 60).toString())
        return toRet
    }

    /* Установить таймер */
    function setTimer(seconds) {
        time = seconds
        timer.start()
    }

    Button {
        id: newGameButton
        text: "New game"
        onClicked: {
            newGame()
        }
    }

    TextField {
        id: timerField
        Layout.fillWidth: true
        font.pointSize: 17
        font.family: "Times New Roman"
        horizontalAlignment: Text.AlignHCenter
        readOnly: true
        /* Таймер в readOnly поле */
        Timer {
            id: timer
            interval: 1000; running: true; repeat: true
            onTriggered: {
                if (time >= 11) {
                    parent.color = "black"
                }
                parent.text = timeToSet(time)
                if (time <= 10) {
                    parent.color = "red"
                }
                time = time - 1
                if (time === -1) {
                    timer.stop()
                    loseDialog()
                }
            }
        }
    }
    /* Кнопка закрытия приложения */
    Button {
        id: quitButton
        text: "Quit"
        onClicked: quitApp()
    }
    /* Горячие клавиши */
    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: ["Ctrl+N"]
        onActivated: {
            newGame()
            timer.start()
        }
    }
    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: [StandardKey.close, "Ctrl+Q"]
        onActivated: quitApp()
    }
}
