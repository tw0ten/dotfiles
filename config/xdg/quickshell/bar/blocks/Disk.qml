import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: BarText {
		text: `(${value})`
	}

	property string value

	Process {
		id: proc
		running: true
		command: ["df", "/", "-h", "--output=avail"]
		stdout: StdioCollector {
			onStreamFinished: () => value = this.text.split("\n")[1].trim()
		}
	}

	Timer {
		interval: 30 * 1000
		running: true
		repeat: true
		onTriggered: proc.running = true
	}
}
