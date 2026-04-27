import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	id: root
	property string user
	property string host

	color: `#ff${Theme.color.accent}`

	content: BarText {
		color: `#ff${Theme.color.background}`
		text: ` ${root.user}@${root.host} `
	}

	Process {
		running: true
		command: ["whoami"]
		stdout: SplitParser {
			onRead: i => root.user = i
		}
	}

	Process {
		running: true
		command: ["uname", "-n"]
		stdout: SplitParser {
			onRead: i => root.host = i
		}
	}
}
