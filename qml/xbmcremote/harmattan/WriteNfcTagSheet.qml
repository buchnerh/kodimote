import QtQuick 1.1
import com.nokia.meego 1.0

Dialog {
    id: writeNfcTagSheet
    //acceptButtonText: "Close"

    Component.onCompleted: {
        nfcHandler.writeTag();
    }

    Component.onDestruction: {
        print("nfc sheet destroyed");
        nfcHandler.cancelWriteTag();
    }

    content: Label {
        height: 200
        width: 400
        anchors.centerIn: parent
        id: textLabel
        text: "Tap a NFC tag to write XBMC connection information to it. You can then use the tag to connect to XBMC."
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font.pointSize: 25
    }

    Connections {
        target: nfcHandler

        onTagWritten: {
            textLabel.text = "Tag written successfully.\nYou can now use this tag\nto connect to XBMC."
            closeButton.text = "Close"
        }
    }

    onRejected: {
        console.log("sheet accepted")
        writeNfcTagSheet.destroy();
    }

    buttons {
        Button {
            id: closeButton
            text: "Cancel"; onClicked: writeNfcTagSheet.reject()
        }
    }
}
