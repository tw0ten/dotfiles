import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property var value: ({
		names: [""],
		current_idx: 0
	})

	content: BarText {
		font: Theme.font.mono
		text: `${root.value.names[root.value.current_idx].substring(0, 2)}`
	}

	Process {
		Component.onCompleted: bar.eventStreamSubs.push(this)

		command: ["niri", "msg", "-j", "keyboard-layouts"]
		stdout: SplitParser {
			onRead: i => root.value = JSON.parse(i)
		}
	}
}
