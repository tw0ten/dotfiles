pragma Singleton

import QtQuick
import Quickshell

Singleton {
	property bool top: false

	property var sizing: Item {
		height: 16
		property real radius: 16 / 2
		property real spacing: 8
	}

	property var font: Item {
		property string family: "system-ui"
		property string mono: "monospace"
		property real size: 9
	}

	property var color: Item {
		property string foreground: "ffffff"
		property string background: "101010"
		property string accent: "40e0d0"
	}
}
