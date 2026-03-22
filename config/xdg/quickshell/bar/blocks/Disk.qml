import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property real valueNumber
	property int valuePrecision: 6

	content: RowLayout {
		spacing: 0

		BarText {
			text: "("
		}
		Fraction {
			prefix: `${Math.trunc(root.valueNumber)}`
			value: root.valueNumber % 1
		}
		BarText {
			text: `${root.valuePrecision})`
		}
	}

	Process {
		id: proc
		running: true
		command: ["df", "/", "--output=avail", "--block-size=1000"]
		stdout: SplitParser {
			splitMarker: ""
			onRead: i => root.valueNumber = i.split("\n")[1] / (10 ** root.valuePrecision)
		}
	}

	Timer {
		interval: 30 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
