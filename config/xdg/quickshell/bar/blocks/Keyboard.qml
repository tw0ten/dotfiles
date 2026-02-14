import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	content: BarText {}

	Process {
		Component.onCompleted: bar.eventStreamSubs.push(this)

		command: ["niri", "msg", "-j", "keyboard-layouts"]
		stdout: SplitParser {
			onRead: i => content.text = JSON.parse(i)["names"][JSON.parse(i)["current_idx"]].substring(0, 2)
		}
	}
}
