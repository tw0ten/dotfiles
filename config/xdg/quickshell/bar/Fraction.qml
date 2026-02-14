import QtQuick

BarText {
	property string prefix: ""
	required property double value
	text: `${prefix}${String.fromCharCode(0xE000 + value * 256)}`
}
