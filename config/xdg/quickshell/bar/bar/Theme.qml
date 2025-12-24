pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property var sizing: Item {
        height: 18
        property real spacing: 8
    }

    property var font: Item {
        property string family: "art"
        property real size: 10
    }

    property var color: Item {
        property string foreground: "ffffff"
        property string background: "101010"
        property string accent: "40e0d0"
    }
}
