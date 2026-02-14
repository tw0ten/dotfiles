import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../"

BarBlock {
	property var sink: Pipewire.defaultAudioSink

	content: Fraction {
		color: `#ff${Theme.color.accent}`
		prefix: "v"
		value: sink?.audio?.muted ? 0 : sink?.audio?.volume
	}

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}
}
