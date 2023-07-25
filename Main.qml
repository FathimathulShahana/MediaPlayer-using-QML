import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Video Player"

    MediaPlayer {
        id: mediaPlayer
        autoPlay: false
        source: videoSource
    }

    FileDialog {
        id: fileDialog
        title: "Open Video File"
        nameFilters: ["Video Files (*.mp4 *.avi *.mov)"]
        onAccepted: {
            videoSource = fileDialog.fileUrl
            mediaPlayer.play()
        }
    }

    Rectangle {
        width: 50
        height: 30
        color: "gray"
        border.color: "black"
        Text {
            anchors.centerIn: parent
            text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            }
        }
    }

    Slider {
        id: progressSlider
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 10
            leftMargin: 50
            rightMargin: 50
        }
        from: 0
        to: mediaPlayer.duration
        stepSize: 100
        value: mediaPlayer.position
        onValueChanged: {
            if (mediaPlayer.playbackState !== MediaPlayer.StoppedState) {
                mediaPlayer.position = value
            }
        }
    }
}
