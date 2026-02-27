import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: "{g"
		}
		Fraction {
			value: valueUsage / 100
		}
		BarText {
			text: `${valueTemp}}`
		}
	}

	property real valueUsage
	property real valueTemp

	Process {
		running: true
		command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=utilization.gpu,temperature.gpu", `--loop=${2}`]
		stdout: SplitParser {
			onRead: i => [valueUsage, valueTemp] = i.split(", ")
		}
	}
}
