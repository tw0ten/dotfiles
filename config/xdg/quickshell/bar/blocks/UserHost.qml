import QtQuick
import Quickshell.Io
import "../"

BarBlock {
	property string user
	property string host

	color: `#ff${Theme.color.accent}`

	content: BarText {
		color: `#ff${Theme.color.background}`
		text: ` ${user}@${host} `
	}

	Process {
		running: true
		command: ["whoami"]
		stdout: SplitParser {
			onRead: i => user = i
		}
	}

	Process {
		running: true
		command: ["uname", "-n"]
		stdout: SplitParser {
			onRead: i => host = i
		}
	}
}
