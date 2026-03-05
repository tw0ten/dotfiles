import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: "("
		}
		Fraction {
			prefix: `${Math.trunc(valueNumber)}`
			value: valueNumber % 1
		}
		BarText {
			text: `${valuePrecision})`
		}
	}

	property real valueNumber
	property int valuePrecision: 6

	Process {
		id: proc
		running: true
		command: ["df", "/", "--output=avail", "--block-size=1000"]
		stdout: SplitParser {
			splitMarker: ""
			onRead: i => valueNumber = i.split("\n")[1] / (10 ** valuePrecision)
		}
	}

	Timer {
		interval: 30 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
