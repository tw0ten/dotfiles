import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../"

BarBlock {
	content: RowLayout {
		spacing: 0

		BarText {
			text: `g{`
		}
		Fraction {
			value: valueUsage
		}
		BarText {
			text: `${Math.round(valueTemp)}}`
		}
	}

	property string valueUsage
	property string valueTemp

	Process {
		id: procUsage
		running: true
		command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=utilization.gpu"]
		stdout: SplitParser {
			onRead: i => valueUsage = i / 100
		}
	}
	Process {
		id: procTemp
		running: true
		command: ["nvidia-smi", "--format=csv,noheader,nounits", "--query-gpu=temperature.gpu"]
		stdout: SplitParser {
			onRead: i => valueTemp = i
		}
	}

	Timer {
		interval: 5 * 1000
		running: true
		repeat: true
		onTriggered: procUsage.running = procTemp.running = true
	}
}
