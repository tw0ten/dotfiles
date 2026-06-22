import Quickshell.Services.Pipewire
import "../"

BarBlock {
	id: root
	property var sink: Pipewire.defaultAudioSink

	content: Fraction {
		prefix: `v${root.sink?.audio?.muted ? '-' : ""}${((i) => i === 0 ? '' : i)(Math.trunc(root.sink?.audio?.volume ?? 0))}`
		value: (root.sink?.audio?.volume ?? 0) % 1
	}

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}
}
