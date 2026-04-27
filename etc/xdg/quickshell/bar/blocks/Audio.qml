import Quickshell.Services.Pipewire
import "../"

BarBlock {
	id: root
	property var sink: Pipewire.defaultAudioSink

	content: Fraction {
		prefix: "v"
		value: root.sink?.audio?.muted ? 0 : root.sink?.audio?.volume ?? 0
	}

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}
}
