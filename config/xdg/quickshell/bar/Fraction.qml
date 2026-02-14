import QtQuick
import QtQuick.Layouts

RowLayout {
	property string prefix: ""
	required property real value

	spacing: 0

	BarText { text: prefix }
	BarText {
		text: `${String.fromCharCode(0xE000 + value * 256)}`
		color: `#ff${Theme.color.accent}`
	}
}
