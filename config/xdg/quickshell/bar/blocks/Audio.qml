import Quickshell.Services.Pipewire
import "../"

BarBlock {
	property var sink: Pipewire.defaultAudioSink

	content: Fraction {
		prefix: "v"
		value: sink?.audio?.muted ? 0 : sink?.audio?.volume ?? 0
	}

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}
}
