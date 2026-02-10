import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../"

BarBlock {
    id: root
    property var sink: Pipewire.defaultAudioSink

    content: BarText {
        color: `#ff${Theme.color.accent}`
        text: `${sink?.audio?.muted ? "󰖁" : "󰕾"}`
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
        onObjectsChanged: {
            sink = Pipewire.defaultAudioSink;
            if (sink?.audio) {
                sink.audio.volumeChanged.connect(() => {
                    if (sink?.audio) {
                        const icon = sink.audio.muted ? "󰖁" : "󰕾";
                        content.text = `${icon} ${Math.round(sink.audio.volume * 100)}%`;
                    }
                });
            }
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
    }
}
