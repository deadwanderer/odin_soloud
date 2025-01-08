package simplest

import sl "../.."
import "core:time"

main :: proc() {
	soloud := sl.Soloud_create()
	speech := sl.Speech_create()

	sl.Speech_setText(speech, "1 2 3   1 2 3   Hello world. Welcome to So-Loud.")

	sl.Soloud_init(soloud)

	sl.Soloud_play(soloud, speech)

	for sl.Soloud_getActiveVoiceCount(soloud) > 0 {
		time.sleep(100 * time.Millisecond)
	}

	sl.Soloud_deinit(soloud)
}
