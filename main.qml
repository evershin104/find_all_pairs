import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

Window {
    /* Количество секунд на 1 раунд игры */
    property int seconds: 25

    id: w
    visible: true
    maximumWidth: 600
    minimumWidth: 600
    width: 600
    height: cl.height
    maximumHeight: cl.height
    minimumHeight: cl.height
    title: qsTr("Find all pairs!")

    ColumnLayout {
        id: cl

        anchors.centerIn: w.contentItem
        spacing: 2
        Gameplay {
            id: gameplay
            onSetTimer: toolbar.setTimer(seconds)
            onWinDialog: {
                toolbar.stopTime()
                win.open()
            }
        }

        Toolbar {
            id: toolbar
            onNewGame:{
                gameplay.newGame()
            }
            onLoseDialog: lose.open()
            onQuitApp: Qt.quit()
        }
    }


    Dialog {
        id: lose
        title: "You lose!"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            gameplay.newGame()
        }
        onRejected: Qt.quit()
        Text {
            text: "Don't worry, it's not so easy. Do you want to try again?"
        }
    }

    Dialog {
        id: win
        title: "Congratulations, you win!"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            gameplay.newGame()
        }
        onRejected: Qt.quit()
        Text {
            text: "Good job! Do you want to try again?"
        }
    }
}

