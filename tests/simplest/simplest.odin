package simplest

import sl "../.."
import "core:fmt"
import "core:time"

main :: proc() {
	soloud := sl.Soloud_create()
	speech := sl.Speech_create()

	sl.Speech_setText(speech, "1 2 3   1 2 3   Hello world. Welcome to So-Loud.")

	sl.Soloud_initEx(soloud, aBackend = .XAudio2)

	fmt.printfln("Version: %v", sl.Soloud_getVersion(soloud))
	fmt.printfln("BackendId: %v", sl.Soloud_getBackendId(soloud))
	fmt.printfln("BackendString: %v", sl.Soloud_getBackendString(soloud))
	fmt.printfln("BackendChannels: %v", sl.Soloud_getBackendChannels(soloud))
	fmt.printfln("BackendSamplerate: %v", sl.Soloud_getBackendSamplerate(soloud))
	fmt.printfln("BackendBufferSize: %v", sl.Soloud_getBackendBufferSize(soloud))
	fmt.printfln("ActiveVoiceCount: %v", sl.Soloud_getActiveVoiceCount(soloud))

	sl.Soloud_play(soloud, speech)

	for sl.Soloud_getActiveVoiceCount(soloud) > 0 {
		time.sleep(100 * time.Millisecond)
	}

	sl.Soloud_deinit(soloud)
}
