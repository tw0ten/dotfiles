pragma Singleton

import QtQuick
import Quickshell

Singleton {
	property var sizing: Item {
		height: 16
		property real spacing: 8
	}

	property var font: Item {
		property string family: "art"
		property string mono: "art.mono"
		property real size: 9
	}

	property var color: Item {
		property string foreground: "ffffff"
		property string background: "101010"
		property string accent: "40e0d0"
	}
}
