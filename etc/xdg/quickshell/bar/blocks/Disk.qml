import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property real value

	content: RowLayout {
		spacing: 0

		BarText {
			text: "("
		}
		Fraction {
			prefix: `${Math.trunc(root.value)}`
			value: root.value % 1
		}
		BarText {
			text: ")"
		}
	}

	Process {
		id: proc
		running: true
		command: ["df", "/", "--output=avail", "--block-size=1000"]
		stdout: SplitParser {
			splitMarker: ""
			onRead: i => root.value = i.split("\n")[1] / (10 ** 6)
		}
	}

	Timer {
		interval: 30 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
