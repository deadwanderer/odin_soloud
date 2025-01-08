package soloud

SOLOUD_DEBUG :: #config(SOLOUD_DEBUG, ODIN_DEBUG)

when ODIN_OS == .Windows {
	when SOLOUD_DEBUG {
		foreign import soloud "lib/windows/debug/soloud_x64_d.lib"
	} else {
		foreign import soloud "lib/windows/release/soloud_x64.lib"
	}
} else {
	#panic("This OS is not currently supported")
}

Handle :: u32
Soloud :: distinct rawptr
AlignedFloatBuffer :: distinct rawptr
TinyAlignedFloatBuffer :: distinct rawptr
Ay :: distinct rawptr
AudioCollider :: distinct rawptr
AudioAttenuator :: distinct rawptr
AudioSource :: rawptr
BassboostFilter :: distinct rawptr
BiquadResonantFilter :: distinct rawptr
Bus :: distinct rawptr
DCRemovalFilter :: distinct rawptr
EchoFilter :: distinct rawptr
Fader :: distinct rawptr
FFTFilter :: distinct rawptr
Filter :: distinct rawptr
FlangerFilter :: distinct rawptr
FreeverbFilter :: distinct rawptr
LofiFilter :: distinct rawptr
Monotone :: distinct rawptr
Noise :: distinct rawptr
Openmpt :: distinct rawptr
Queue :: distinct rawptr
RobotizeFilter :: distinct rawptr
Sfxr :: distinct rawptr
Speech :: rawptr
TedSid :: distinct rawptr
Vic :: distinct rawptr
Vizsn :: distinct rawptr
Wav :: distinct rawptr
WaveShaperFilter :: distinct rawptr
WavStream :: distinct rawptr
File :: distinct rawptr

Soloud_Flag :: enum u32 {
	Clip_Roundoff          = 0,
	Enable_Visualization   = 1,
	Left_Handed_3D         = 2,
	No_FPU_Register_Change = 3,
}
Flags :: bit_set[Soloud_Flag;u32]

Result :: enum i32 {
	SO_NO_ERROR       = 0, // No error
	INVALID_PARAMETER = 1, // Some parameter is invalid
	FILE_NOT_FOUND    = 2, // File not found
	FILE_LOAD_FAILED  = 3, // File found, but could not be loaded
	DLL_NOT_FOUND     = 4, // DLL not found, or wrong DLL
	OUT_OF_MEMORY     = 5, // Out of memory
	NOT_IMPLEMENTED   = 6, // Feature not implemented
	UNKNOWN_ERROR     = 7, // Other error
}

Backend :: enum u32 {
	Auto          = 0,
	SDL1          = 1,
	SDL2          = 2,
	PortAudio     = 3,
	Winmm         = 4,
	XAudio2       = 5,
	Wasapi        = 6,
	Alsa          = 7,
	Jack          = 8,
	Oss           = 9,
	OpenAL        = 10,
	CoreAudio     = 11,
	OpenSLES      = 12,
	Vita_Homebrew = 13,
	MiniAudio     = 14,
	NoSound       = 15,
	NullDriver    = 16,
}

@(default_calling_convention = "c")
foreign soloud {
	Soloud_create :: proc() -> ^Soloud ---
	Soloud_destroy :: proc(aSoloud: ^Soloud) ---
	Soloud_init :: proc(aSoloud: ^Soloud) -> Result ---
	Soloud_initEx :: proc(aSoloud: ^Soloud, aFlags: Flags = {.Clip_Roundoff}, aBackend: Backend = .Auto, aSampleRate: u32 = 0, aBufferSize: u32 = 0, aChannels: u32 = 2) -> Result ---
	Soloud_pause :: proc(aSoloud: ^Soloud) -> Result ---
	Soloud_resume :: proc(aSoloud: ^Soloud) -> Result ---
	Soloud_deinit :: proc(aSoloud: ^Soloud) ---
	Soloud_getVersion :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getErrorString :: proc(aSoloud: ^Soloud, aErrorCode: i32) -> cstring ---
	Soloud_play :: proc(aSoloud: ^Soloud, aSound: ^AudioSource) -> Handle ---
	Soloud_getActiveVoiceCount :: proc(aSoloud: ^Soloud) -> u32 ---


	/*
   * Speech
   */
	Speech_destroy :: proc(aSpeech: ^Speech) ---
	Speech_create :: proc() -> ^Speech ---
	Speech_setText :: proc(aSpeech: ^Speech, aText: cstring) -> Result ---
}
