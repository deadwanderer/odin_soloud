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
	SO_No_Error       = 0, // No error
	Invalid_Parameter = 1, // Some parameter is invalid
	File_Not_Found    = 2, // File not found
	File_Load_Failed  = 3, // File found, but could not be loaded
	DLL_Not_Found     = 4, // DLL not found, or wrong DLL
	Out_Of_Memory     = 5, // Out of memory
	Not_Implemented   = 6, // Feature not implemented
	Unknown_Error     = 7, // Other error
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
	Soloud_getBackendId :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getBackendString :: proc(aSoloud: ^Soloud) -> cstring ---
	Soloud_getBackendChannels :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getBackendSamplerate :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getBackendBufferSize :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_setSpeakerPosition :: proc(aSoloud: ^Soloud, aChannel: u32, aX: f32, aY: f32, aZ: f32) -> b32 ---
	Soloud_getSpeakerPosition :: proc(aSoloud: ^Soloud, aChannel: u32, aX: ^f32, aY: ^f32, aZ: ^f32) -> b32 ---
	Soloud_play :: proc(aSoloud: ^Soloud, aSound: ^AudioSource) -> Handle ---
	Soloud_playEx :: proc(aSoloud: ^Soloud,
		aSound: ^AudioSource,
		aVolume: f32, /* = -1.0f */
		aPan: f32, /* = 0.0f */
		aPaused: b32, /* = 0 */
		aBus: u32, /* = 0 */) -> u32 ---
	Soloud_playClocked :: proc(aSoloud: ^Soloud, aSoundTime: f64, aSound: ^AudioSource) -> u32 ---
	Soloud_playClockedEx :: proc(aSoloud: ^Soloud,
		aSoundTime: f64,
		aSound: ^AudioSource,
		aVolume: f32, /* = -1.0f */
		aPan: f32, /* = 0.0f */
		aBus: u32, /* = 0 */) -> u32 ---
	Soloud_play3d :: proc(aSoloud: ^Soloud, aSound: ^AudioSource, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---
	Soloud_play3dEx :: proc(aSoloud: ^Soloud,
		aSound: ^AudioSource,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aVelX: f32, /* = 0.0f */
		aVelY: f32, /* = 0.0f */
		aVelZ: f32, /* = 0.0f */
		aVolume: f32, /* = 1.0f */
		aPaused: b32, /* = 0 */
		aBus: u32, /* = 0 */) -> u32 ---
	Soloud_play3dClocked :: proc(aSoloud: ^Soloud, aSoundTime: f64, aSound: ^AudioSource, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---
	Soloud_play3dClockedEx :: proc(aSoloud: ^Soloud,
		aSoundTime: f64,
		aSound: ^AudioSource,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aVelX: f32, /* = 0.0f */
		aVelY: f32, /* = 0.0f */
		aVelZ: f32, /* = 0.0f */
		aVolume: f32, /* = 1.0f */
		aBus: u32, /* = 0 */) -> u32 ---
	Soloud_playBackground :: proc(aSoloud: ^Soloud, aSound: ^AudioSource) -> u32 ---
	Soloud_playBackgroundEx :: proc(aSoloud: ^Soloud,
		aSound: ^AudioSource,
		aVolume: f32, /* = -1.0f */
		aPaused: b32, /* = 0 */
		aBus: u32, /* = 0 */) -> u32 ---
	Soloud_seek :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aSeconds: f64) -> i32 --- // TODO: should be b32?
	Soloud_stop :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) ---
	Soloud_stopAll :: proc(aSoloud: ^Soloud) ---
	Soloud_stopAudioSource :: proc(aSoloud: ^Soloud, aSound: ^AudioSource) ---
	Soloud_countAudioSource :: proc(aSoloud: ^Soloud, aSound: ^AudioSource) -> b32 ---
	Soloud_setFilterParameter :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aValue: f32) ---
	Soloud_getFilterParameter :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32) -> f32 ---
	Soloud_fadeFilterParameter :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aTo: f32, aTime: f64) ---
	Soloud_oscillateFilterParameter :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aFrom: f32, aTo: f32, aTime: f64) ---
	Soloud_getStreamTime :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f64 ---
	Soloud_getStreamPosition :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f64 ---
	Soloud_getPause :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> b32 ---
	Soloud_getVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f32 ---
	Soloud_getOverallVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f32 ---
	Soloud_getPan :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f32 ---
	Soloud_getSamplerate :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f32 ---
	Soloud_getProtectVoice :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> b32 ---
	Soloud_getActiveVoiceCount :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getVoiceCount :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_isValidVoiceHandle :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> b32 ---
	Soloud_getRelativePlaySpeed :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f32 ---
	Soloud_getPostClipScaler :: proc(aSoloud: ^Soloud) -> f32 ---
	Soloud_getMainResampler :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getGlobalVolume :: proc(aSoloud: ^Soloud) -> f32 ---
	Soloud_getMaxActiveVoiceCount :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_getLooping :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> b32 ---
	Soloud_getAutoStop :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> b32 ---
	Soloud_getLoopPoint :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> f64 ---
	Soloud_setLoopPoint :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aLoopPoint: f64) ---
	Soloud_setLooping :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aLooping: b32) ---
	Soloud_setAutoStop :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aAutoStop: b32) ---
	Soloud_setMaxActiveVoiceCount :: proc(aSoloud: ^Soloud, aVoiceCount: u32) -> i32 --- // TODO: should be b32?
	Soloud_setInaudibleBehavior :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aMustTick: b32, aKill: b32) ---
	Soloud_setGlobalVolume :: proc(aSoloud: ^Soloud, aVolume: f32) ---
	Soloud_setPostClipScaler :: proc(aSoloud: ^Soloud, aScaler: f32) ---
	Soloud_setMainResampler :: proc(aSoloud: ^Soloud, aResampler: u32) ---
	Soloud_setPause :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aPause: b32) ---
	Soloud_setPauseAll :: proc(aSoloud: ^Soloud, aPause: b32) ---
	Soloud_setRelativePlaySpeed :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aSpeed: f32) -> i32 --- // TODO: should be b32?
	Soloud_setProtectVoice :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aProtect: b32) ---
	Soloud_setSamplerate :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aSampleRate: f32) ---
	Soloud_setPan :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aPan: f32) ---
	Soloud_setPanAbsolute :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aLVolume: f32, aRVolume: f32) ---
	Soloud_setChannelVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aChannel: u32, aVolume: f32) ---
	Soloud_setVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aVolume: f32) ---
	Soloud_setDelaySamples :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aSamples: u32) ---
	Soloud_fadeVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---
	Soloud_fadePan :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---
	Soloud_fadeRelativePlaySpeed :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---
	Soloud_fadeGlobalVolume :: proc(aSoloud: ^Soloud, aTo: f32, aTime: f64) ---
	Soloud_schedulePause :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aTime: f64) ---
	Soloud_scheduleStop :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aTime: f64) ---
	Soloud_oscillateVolume :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---
	Soloud_oscillatePan :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---
	Soloud_oscillateRelativePlaySpeed :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---
	Soloud_oscillateGlobalVolume :: proc(aSoloud: ^Soloud, aFrom: f32, aTo: f32, aTime: f64) ---
	Soloud_setGlobalFilter :: proc(aSoloud: ^Soloud, aFilterId: u32, aFilter: ^Filter) ---
	Soloud_setVisualizationEnable :: proc(aSoloud: ^Soloud, aEnable: b32) ---
	Soloud_calcFFT :: proc(aSoloud: ^Soloud) -> ^f32 --- // TODO: should be [^]f32?
	Soloud_getWave :: proc(aSoloud: ^Soloud) -> ^f32 --- // TODO: should be [^]f32?
	Soloud_getApproximateVolume :: proc(aSoloud: ^Soloud, aChannel: u32) -> f32 ---
	Soloud_getLoopCount :: proc(aSoloud: ^Soloud, aVoiceHandle: u32) -> u32 ---
	Soloud_getInfo :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aInfoKey: u32) -> f32 ---
	Soloud_createVoiceGroup :: proc(aSoloud: ^Soloud) -> u32 ---
	Soloud_destroyVoiceGroup :: proc(aSoloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 --- // TODO: should be b32?
	Soloud_addVoiceToGroup :: proc(aSoloud: ^Soloud, aVoiceGroupHandle: u32, aVoiceHandle: u32) -> i32 --- // TODO: should be b32?
	Soloud_isVoiceGroup :: proc(aSoloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 --- // TODO: should be b32?
	Soloud_isVoiceGroupEmpty :: proc(aSoloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 --- // TODO: should be b32?
	Soloud_update3dAudio :: proc(aSoloud: ^Soloud) ---
	Soloud_set3dSoundSpeed :: proc(aSoloud: ^Soloud, aSpeed: f32) -> i32 --- // TODO: should be b32?
	Soloud_get3dSoundSpeed :: proc(aSoloud: ^Soloud) -> f32 ---
	Soloud_set3dListenerParameters :: proc(aSoloud: ^Soloud, aPosX: f32, aPosY: f32, aPosZ: f32, aAtX: f32, aAtY: f32, aAtZ: f32, aUpX: f32, aUpY: f32, aUpZ: f32) ---
	Soloud_set3dListenerParametersEx :: proc(aSoloud: ^Soloud,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aAtX: f32,
		aAtY: f32,
		aAtZ: f32,
		aUpX: f32,
		aUpY: f32,
		aUpZ: f32,
		aVelocityX: f32, /* = 0.0f */
		aVelocityY: f32, /* = 0.0f */
		aVelocityZ: f32, /* = 0.0f */) ---
	Soloud_set3dListenerPosition :: proc(aSoloud: ^Soloud, aPosX: f32, aPosY: f32, aPosZ: f32) ---
	Soloud_set3dListenerAt :: proc(aSoloud: ^Soloud, aAtX: f32, aAtY: f32, aAtZ: f32) ---
	Soloud_set3dListenerUp :: proc(aSoloud: ^Soloud, aUpX: f32, aUpY: f32, aUpZ: f32) ---
	Soloud_set3dListenerVelocity :: proc(aSoloud: ^Soloud, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---
	Soloud_set3dSourceParameters :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aPosX: f32, aPosY: f32, aPosZ: f32) ---
	Soloud_set3dSourceParametersEx :: proc(aSoloud: ^Soloud,
		aVoiceHandle: u32,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aVelocityX: f32, /* = 0.0f */
		aVelocityY: f32, /* = 0.0f */
		aVelocityZ: f32, /* = 0.0f */) ---
	Soloud_set3dSourcePosition :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aPosX: f32, aPosY: f32, aPosZ: f32) ---
	Soloud_set3dSourceVelocity :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---
	Soloud_set3dSourceMinMaxDistance :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aMinDistance: f32, aMaxDistance: f32) ---
	Soloud_set3dSourceAttenuation :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---
	Soloud_set3dSourceDopplerFactor :: proc(aSoloud: ^Soloud, aVoiceHandle: u32, aDopplerFactor: f32) ---
	Soloud_mix :: proc(aSoloud: ^Soloud, aBuffer: [^]f32, aSamples: u32) ---
	Soloud_mixSigned16 :: proc(aSoloud: ^Soloud, aBuffer: [^]i16, aSamples: u32) ---

	/*
 * Ay
 */
	Ay_destroy :: proc(aAy: ^Ay) ---
	Ay_create :: proc() -> ^Ay ---
	Ay_setVolume :: proc(aAy: ^Ay, aVolume: f32) ---
	Ay_setLooping :: proc(aAy: ^Ay, aLoop: b32) ---
	Ay_setAutoStop :: proc(aAy: ^Ay, aAutoStop: b32) ---
	Ay_set3dMinMaxDistance :: proc(aAy: ^Ay, aMinDistance: f32, aMaxDistance: f32) ---
	Ay_set3dAttenuation :: proc(aAy: ^Ay, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---
	Ay_set3dDopplerFactor :: proc(aAy: ^Ay, aDopplerFactor: f32) ---
	Ay_set3dListenerRelative :: proc(aAy: ^Ay, aListenerRelative: b32) ---
	Ay_set3dDistanceDelay :: proc(aAy: ^Ay, aDistanceDelay: b32) ---
	Ay_set3dCollider :: proc(aAy: ^Ay, aCollider: ^AudioCollider) ---
	Ay_set3dColliderEx :: proc(aAy: ^Ay,
		aCollider: ^AudioCollider,
		aUserData: b32, /* = 0 */) ---
	Ay_set3dAttenuator :: proc(aAy: ^Ay, aAttenuator: ^AudioAttenuator) ---
	Ay_setInaudibleBehavior :: proc(aAy: ^Ay, aMustTick: b32, aKill: b32) ---
	Ay_setLoopPoint :: proc(aAy: ^Ay, aLoopPoint: f64) ---
	Ay_getLoopPoint :: proc(aAy: ^Ay) -> f64 ---
	Ay_setFilter :: proc(aAy: ^Ay, aFilterId: u32, aFilter: ^Filter) ---
	Ay_stop :: proc(aAy: ^Ay) ---

	/*
 * BassboostFilter
 */
	BassboostFilter_destroy :: proc(aBassboostFilter: ^BassboostFilter) ---
	BassboostFilter_getParamCount :: proc(aBassboostFilter: ^BassboostFilter) -> i32 ---
	BassboostFilter_getParamName :: proc(aBassboostFilter: ^BassboostFilter, aParamIndex: u32) -> cstring ---
	BassboostFilter_getParamType :: proc(aBassboostFilter: ^BassboostFilter, aParamIndex: u32) -> u32 ---
	BassboostFilter_getParamMax :: proc(aBassboostFilter: ^BassboostFilter, aParamIndex: u32) -> f32 ---
	BassboostFilter_getParamMin :: proc(aBassboostFilter: ^BassboostFilter, aParamIndex: u32) -> f32 ---
	BassboostFilter_setParams :: proc(aBassboostFilter: ^BassboostFilter, aBoost: f32) -> b32 ---
	BassboostFilter_create :: proc() -> ^BassboostFilter ---

	/*
		* BiquadResonantFilter
		*/
	BiquadResonantFilter_destroy :: proc(aBiquadResonantFilter: ^BiquadResonantFilter) ---
	BiquadResonantFilter_getParamCount :: proc(aBiquadResonantFilter: ^BiquadResonantFilter) -> i32 ---
	BiquadResonantFilter_getParamName :: proc(aBiquadResonantFilter: ^BiquadResonantFilter, aParamIndex: u32) -> cstring ---
	BiquadResonantFilter_getParamType :: proc(aBiquadResonantFilter: ^BiquadResonantFilter, aParamIndex: u32) -> u32 ---
	BiquadResonantFilter_getParamMax :: proc(aBiquadResonantFilter: ^BiquadResonantFilter, aParamIndex: u32) -> f32 ---
	BiquadResonantFilter_getParamMin :: proc(aBiquadResonantFilter: ^BiquadResonantFilter, aParamIndex: u32) -> f32 ---
	BiquadResonantFilter_create :: proc() -> ^BiquadResonantFilter ---
	BiquadResonantFilter_setParams :: proc(aBiquadResonantFilter: ^BiquadResonantFilter, aType: i32, aFrequency: f32, aResonance: f32) -> b32 ---

	/*
		* Bus
		*/
	Bus_destroy :: proc(aBus: ^Bus) ---
	Bus_create :: proc() -> ^Bus ---
	Bus_setFilter :: proc(aBus: ^Bus, aFilterId: u32, aFilter: ^Filter) ---
	Bus_play :: proc(aBus: ^Bus, aSound: ^AudioSource) -> u32 ---
	Bus_playEx :: proc(aBus: ^Bus,
		aSound: ^AudioSource,
		aVolume: f32, /* = 1.0f */
		aPan: f32, /* = 0.0f */
		aPaused: b32, /* = 0 */) -> u32 ---
	Bus_playClocked :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^AudioSource) -> u32 ---
	Bus_playClockedEx :: proc(aBus: ^Bus,
		aSoundTime: f64,
		aSound: ^AudioSource,
		aVolume: f32, /* = 1.0f */
		aPan: f32, /* = 0.0f */) -> u32 ---
	Bus_play3d :: proc(aBus: ^Bus, aSound: ^AudioSource, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---
	Bus_play3dEx :: proc(aBus: ^Bus,
		aSound: ^AudioSource,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aVelX: f32, /* = 0.0f */
		aVelY: f32, /* = 0.0f */
		aVelZ: f32, /* = 0.0f */
		aVolume: f32, /* = 1.0f */
		aPaused: b32, /* = 0 */) -> u32 ---
	Bus_play3dClocked :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^AudioSource, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---
	Bus_play3dClockedEx :: proc(aBus: ^Bus,
		aSoundTime: f64,
		aSound: ^AudioSource,
		aPosX: f32,
		aPosY: f32,
		aPosZ: f32,
		aVelX: f32, /* = 0.0f */
		aVelY: f32, /* = 0.0f */
		aVelZ: f32, /* = 0.0f */
		aVolume: f32, /* = 1.0f */) -> u32 ---
	Bus_setChannels :: proc(aBus: ^Bus, aChannels: u32) -> i32 --- // TODO: Should be bool?
	Bus_setVisualizationEnable :: proc(aBus: ^Bus, aEnable: b32) ---
	Bus_annexSound :: proc(aBus: ^Bus, aVoiceHandle: u32) ---
	Bus_calcFFT :: proc(aBus: ^Bus) -> ^f32 --- // TODO: should be [^]f32?
	Bus_getWave :: proc(aBus: ^Bus) -> ^f32 --- // TODO: should be [^]f32?
	Bus_getApproximateVolume :: proc(aBus: ^Bus, aChannel: u32) -> f32 ---
	Bus_getActiveVoiceCount :: proc(aBus: ^Bus) -> u32 ---
	Bus_getResampler :: proc(aBus: ^Bus) -> u32 ---
	Bus_setResampler :: proc(aBus: ^Bus, aResampler: u32) ---
	Bus_setVolume :: proc(aBus: ^Bus, aVolume: f32) ---
	Bus_setLooping :: proc(aBus: ^Bus, aLoop: b32) ---
	Bus_setAutoStop :: proc(aBus: ^Bus, aAutoStop: b32) ---
	Bus_set3dMinMaxDistance :: proc(aBus: ^Bus, aMinDistance: f32, aMaxDistance: f32) ---
	Bus_set3dAttenuation :: proc(aBus: ^Bus, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---
	Bus_set3dDopplerFactor :: proc(aBus: ^Bus, aDopplerFactor: f32) ---
	Bus_set3dListenerRelative :: proc(aBus: ^Bus, aListenerRelative: b32) ---
	Bus_set3dDistanceDelay :: proc(aBus: ^Bus, aDistanceDelay: b32) ---
	Bus_set3dCollider :: proc(aBus: ^Bus, aCollider: ^AudioCollider) ---
	Bus_set3dColliderEx :: proc(aBus: ^Bus,
		aCollider: ^AudioCollider,
		aUserData: b32, /* = 0 */) ---
	Bus_set3dAttenuator :: proc(aBus: ^Bus, aAttenuator: ^AudioAttenuator) ---
	Bus_setInaudibleBehavior :: proc(aBus: ^Bus, aMustTick: b32, aKill: b32) ---
	Bus_setLoopPoint :: proc(aBus: ^Bus, aLoopPoint: f64) ---
	Bus_getLoopPoint :: proc(aBus: ^Bus) -> f64 ---
	Bus_stop :: proc(aBus: ^Bus) ---

	/*
 * DCRemovalFilter
 */
	DCRemovalFilter_destroy :: proc(aDCRemovalFilter: ^DCRemovalFilter) ---
	DCRemovalFilter_create :: proc() -> DCRemovalFilter ---
	DCRemovalFilter_setParams :: proc(aDCRemovalFilter: ^DCRemovalFilter) -> i32 ---
	DCRemovalFilter_setParamsEx :: proc(aDCRemovalFilter: ^DCRemovalFilter,
		aLength: f32, /* = 0.1f */) -> i32 ---
	DCRemovalFilter_getParamCount :: proc(aDCRemovalFilter: ^DCRemovalFilter) -> i32 ---
	DCRemovalFilter_getParamName :: proc(aDCRemovalFilter: ^DCRemovalFilter, aParamIndex: u32) -> cstring ---
	DCRemovalFilter_getParamType :: proc(aDCRemovalFilter: ^DCRemovalFilter, aParamIndex: u32) -> u32 ---
	DCRemovalFilter_getParamMax :: proc(aDCRemovalFilter: ^DCRemovalFilter, aParamIndex: u32) -> f32 ---
	DCRemovalFilter_getParamMin :: proc(aDCRemovalFilter: ^DCRemovalFilter, aParamIndex: u32) -> f32 ---

	/*
		* EchoFilter
		*/
	EchoFilter_destroy :: proc(aEchoFilter: ^EchoFilter) ---
	EchoFilter_getParamCount :: proc(aEchoFilter: ^EchoFilter) -> i32 ---
	EchoFilter_getParamName :: proc(aEchoFilter: ^EchoFilter, aParamIndex: u32) -> cstring ---
	EchoFilter_getParamType :: proc(aEchoFilter: ^EchoFilter, aParamIndex: u32) -> u32 ---
	EchoFilter_getParamMax :: proc(aEchoFilter: ^EchoFilter, aParamIndex: u32) -> f32 ---
	EchoFilter_getParamMin :: proc(aEchoFilter: ^EchoFilter, aParamIndex: u32) -> f32 ---
	EchoFilter_create :: proc() -> ^EchoFilter ---
	EchoFilter_setParams :: proc(aEchoFilter: ^EchoFilter, aDelay: f32) -> b32 ---
	EchoFilter_setParamsEx :: proc(aEchoFilter: ^EchoFilter,
		aDelay: f32,
		aDecay: f32, /* = 0.7f */
		aFilter: f32, /* = 0.0f */) -> b32 ---

	/*
		* FFTFilter
		*/
	FFTFilter_destroy :: proc(aFFTFilter: ^FFTFilter) ---
	FFTFilter_create :: proc() -> ^FFTFilter ---
	FFTFilter_getParamCount :: proc(aFFTFilter: ^FFTFilter) -> i32 ---
	FFTFilter_getParamName :: proc(aFFTFilter: ^FFTFilter, aParamIndex: u32) -> cstring ---
	FFTFilter_getParamType :: proc(aFFTFilter: ^FFTFilter, aParamIndex: u32) -> u32 ---
	FFTFilter_getParamMax :: proc(aFFTFilter: ^FFTFilter, aParamIndex: u32) -> f32 ---
	FFTFilter_getParamMin :: proc(aFFTFilter: ^FFTFilter, aParamIndex: u32) -> f32 ---

	/*
		* FlangerFilter
		*/
	FlangerFilter_destroy :: proc(aFlangerFilter: ^FlangerFilter) ---
	FlangerFilter_getParamCount :: proc(aFlangerFilter: ^FlangerFilter) -> i32 ---
	FlangerFilter_getParamName :: proc(aFlangerFilter: ^FlangerFilter, aParamIndex: u32) -> cstring ---
	FlangerFilter_getParamType :: proc(aFlangerFilter: ^FlangerFilter, aParamIndex: u32) -> u32 ---
	FlangerFilter_getParamMax :: proc(aFlangerFilter: ^FlangerFilter, aParamIndex: u32) -> f32 ---
	FlangerFilter_getParamMin :: proc(aFlangerFilter: ^FlangerFilter, aParamIndex: u32) -> f32 ---
	FlangerFilter_create :: proc() -> ^FlangerFilter ---
	FlangerFilter_setParams :: proc(aFlangerFilter: ^FlangerFilter, aDelay: f32, aFreq: f32) -> b32 ---

	/*
		* FreeverbFilter
		*/
	FreeverbFilter_destroy :: proc(aFreeverbFilter: ^FreeverbFilter) ---
	FreeverbFilter_getParamCount :: proc(aFreeverbFilter: ^FreeverbFilter) -> i32 ---
	FreeverbFilter_getParamName :: proc(aFreeverbFilter: ^FreeverbFilter, aParamIndex: u32) -> cstring ---
	FreeverbFilter_getParamType :: proc(aFreeverbFilter: ^FreeverbFilter, aParamIndex: u32) -> u32 ---
	FreeverbFilter_getParamMax :: proc(aFreeverbFilter: ^FreeverbFilter, aParamIndex: u32) -> f32 ---
	FreeverbFilter_getParamMin :: proc(aFreeverbFilter: ^FreeverbFilter, aParamIndex: u32) -> f32 ---
	FreeverbFilter_create :: proc() -> ^FreeverbFilter ---
	FreeverbFilter_setParams :: proc(aFreeverbFilter: ^FreeverbFilter, aMode: f32, aRoomSize: f32, aDamp: f32, aWidth: f32) -> b32 ---

	/*
		* LofiFilter
		*/
	LofiFilter_destroy :: proc(aLofiFilter: ^LofiFilter) ---
	LofiFilter_getParamCount :: proc(aLofiFilter: ^LofiFilter) -> i32 ---
	LofiFilter_getParamName :: proc(aLofiFilter: ^LofiFilter, aParamIndex: u32) -> cstring ---
	LofiFilter_getParamType :: proc(aLofiFilter: ^LofiFilter, aParamIndex: u32) -> u32 ---
	LofiFilter_getParamMax :: proc(aLofiFilter: ^LofiFilter, aParamIndex: u32) -> f32 ---
	LofiFilter_getParamMin :: proc(aLofiFilter: ^LofiFilter, aParamIndex: u32) -> f32 ---
	LofiFilter_create :: proc() -> ^LofiFilter ---
	LofiFilter_setParams :: proc(aLofiFilter: ^LofiFilter, aSampleRate: f32, aBitdepth: f32) -> b32 ---

	//
	// TODO: READY FOR MONOTONE
	//
	/*
 * Monotone
 */
	// Monotone_destroy :: proc(aMonotone: ^Monotone) ---
	//  Monotone_create :: proc() ->^Monotone---
	// Monotone_setParams :: proc(aMonotone: ^Monotone, aHardwareChannels: b32) ->i32 ---
	// Monotone_setParamsEx :: proc(aMonotone: ^Monotone, aHardwareChannels: b32, aWaveform: b32 /* = Soloud::WAVE_SQUARE */) ->i32 ---
	// Monotone_load :: proc(aMonotone: ^Monotone, const char * aFilename) ->i32 ---
	// Monotone_loadMem :: proc(aMonotone: ^Monotone, const unsigned char * aMem, unsigned int aLength) ->i32 ---
	// Monotone_loadMemEx :: proc(aMonotone: ^Monotone, const unsigned char * aMem, unsigned int aLength, int aCopy /* = false */, int aTakeOwnership /* = true */) ->i32 ---
	// Monotone_loadFile :: proc(aMonotone: ^Monotone, File * aFile) ->i32 ---
	// Monotone_setVolume :: proc(aMonotone: ^Monotone, aVolume: f32) ---
	// Monotone_setLooping :: proc(aMonotone: ^Monotone, aLoop: b32) ---
	// Monotone_setAutoStop :: proc(aMonotone: ^Monotone, aAutoStop: b32) ---
	// Monotone_set3dMinMaxDistance :: proc(aMonotone: ^Monotone, aMinDistance: f32, aMaxDistance: f32) ---
	// Monotone_set3dAttenuation :: proc(aMonotone: ^Monotone, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Monotone_set3dDopplerFactor :: proc(aMonotone: ^Monotone, aDopplerFactor: f32) ---
	// Monotone_set3dListenerRelative :: proc(aMonotone: ^Monotone, int aListenerRelative) ---
	// Monotone_set3dDistanceDelay :: proc(aMonotone: ^Monotone, int aDistanceDelay) ---
	// Monotone_set3dCollider :: proc(aMonotone: ^Monotone, aCollider: ^AudioCollider) ---
	// Monotone_set3dColliderEx :: proc(aMonotone: ^Monotone, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Monotone_set3dAttenuator :: proc(aMonotone: ^Monotone, aAttenuator: ^AudioAttenuator) ---
	// Monotone_setInaudibleBehavior :: proc(aMonotone: ^Monotone, aMustTick: b32, aKill: b32) ---
	// Monotone_setLoopPoint :: proc(aMonotone: ^Monotone, double aLoopPoint) ---
	//  Monotone_getLoopPoint :: proc(aMonotone: ^Monotone) ->f64---
	// Monotone_setFilter :: proc(aMonotone: ^Monotone, unsigned int aFilterId, aFilter: ^Filter) ---
	// Monotone_stop :: proc(aMonotone: ^Monotone) ---

	// /*
	//  * Noise
	//  */
	// Noise_destroy :: proc(aNoise: ^Noise) ---
	// Noise * Noise_create :: proc() ---
	// Noise_setOctaveScale :: proc(aNoise: ^Noise, float aOct0, float aOct1, float aOct2, float aOct3, float aOct4, float aOct5, float aOct6, float aOct7, float aOct8, float aOct9) ---
	// Noise_setType :: proc(aNoise: ^Noise, int aType) ---
	// Noise_setVolume :: proc(aNoise: ^Noise, aVolume: f32) ---
	// Noise_setLooping :: proc(aNoise: ^Noise, aLoop: b32) ---
	// Noise_setAutoStop :: proc(aNoise: ^Noise, aAutoStop: b32) ---
	// Noise_set3dMinMaxDistance :: proc(aNoise: ^Noise, aMinDistance: f32, aMaxDistance: f32) ---
	// Noise_set3dAttenuation :: proc(aNoise: ^Noise, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Noise_set3dDopplerFactor :: proc(aNoise: ^Noise, aDopplerFactor: f32) ---
	// Noise_set3dListenerRelative :: proc(aNoise: ^Noise, int aListenerRelative) ---
	// Noise_set3dDistanceDelay :: proc(aNoise: ^Noise, int aDistanceDelay) ---
	// Noise_set3dCollider :: proc(aNoise: ^Noise, aCollider: ^AudioCollider) ---
	// Noise_set3dColliderEx :: proc(aNoise: ^Noise, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Noise_set3dAttenuator :: proc(aNoise: ^Noise, aAttenuator: ^AudioAttenuator) ---
	// Noise_setInaudibleBehavior :: proc(aNoise: ^Noise, aMustTick: b32, aKill: b32) ---
	// Noise_setLoopPoint :: proc(aNoise: ^Noise, double aLoopPoint) ---
	// double Noise_getLoopPoint :: proc(aNoise: ^Noise) ---
	// Noise_setFilter :: proc(aNoise: ^Noise, unsigned int aFilterId, aFilter: ^Filter) ---
	// Noise_stop :: proc(aNoise: ^Noise) ---

	// /*
	//  * Openmpt
	//  */
	// Openmpt_destroy :: proc(aOpenmpt: ^Openmpt) ---
	// Openmpt * Openmpt_create :: proc() ---
	// int Openmpt_load :: proc(aOpenmpt: ^Openmpt, const char * aFilename) ---
	// int Openmpt_loadMem :: proc(aOpenmpt: ^Openmpt, const unsigned char * aMem, unsigned int aLength) ---
	// int Openmpt_loadMemEx :: proc(aOpenmpt: ^Openmpt, const unsigned char * aMem, unsigned int aLength, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// int Openmpt_loadFile :: proc(aOpenmpt: ^Openmpt, File * aFile) ---
	// Openmpt_setVolume :: proc(aOpenmpt: ^Openmpt, aVolume: f32) ---
	// Openmpt_setLooping :: proc(aOpenmpt: ^Openmpt, aLoop: b32) ---
	// Openmpt_setAutoStop :: proc(aOpenmpt: ^Openmpt, aAutoStop: b32) ---
	// Openmpt_set3dMinMaxDistance :: proc(aOpenmpt: ^Openmpt, aMinDistance: f32, aMaxDistance: f32) ---
	// Openmpt_set3dAttenuation :: proc(aOpenmpt: ^Openmpt, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Openmpt_set3dDopplerFactor :: proc(aOpenmpt: ^Openmpt, aDopplerFactor: f32) ---
	// Openmpt_set3dListenerRelative :: proc(aOpenmpt: ^Openmpt, int aListenerRelative) ---
	// Openmpt_set3dDistanceDelay :: proc(aOpenmpt: ^Openmpt, int aDistanceDelay) ---
	// Openmpt_set3dCollider :: proc(aOpenmpt: ^Openmpt, aCollider: ^AudioCollider) ---
	// Openmpt_set3dColliderEx :: proc(aOpenmpt: ^Openmpt, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Openmpt_set3dAttenuator :: proc(aOpenmpt: ^Openmpt, aAttenuator: ^AudioAttenuator) ---
	// Openmpt_setInaudibleBehavior :: proc(aOpenmpt: ^Openmpt, aMustTick: b32, aKill: b32) ---
	// Openmpt_setLoopPoint :: proc(aOpenmpt: ^Openmpt, double aLoopPoint) ---
	// double Openmpt_getLoopPoint :: proc(aOpenmpt: ^Openmpt) ---
	// Openmpt_setFilter :: proc(aOpenmpt: ^Openmpt, unsigned int aFilterId, aFilter: ^Filter) ---
	// Openmpt_stop :: proc(aOpenmpt: ^Openmpt) ---

	// /*
	//  * Queue
	//  */
	// Queue_destroy :: proc(aQueue: ^Queue) ---
	// Queue * Queue_create :: proc() ---
	// int Queue_play :: proc(aQueue: ^Queue, AudioSource * aSound) ---
	// unsigned int Queue_getQueueCount :: proc(aQueue: ^Queue) ---
	// int Queue_isCurrentlyPlaying :: proc(aQueue: ^Queue, AudioSource * aSound) ---
	// int Queue_setParamsFromAudioSource :: proc(aQueue: ^Queue, AudioSource * aSound) ---
	// int Queue_setParams :: proc(aQueue: ^Queue, aSamplerate: f32) ---
	// int Queue_setParamsEx :: proc(aQueue: ^Queue, aSamplerate: f32, unsigned int aChannels /* = 2 */) ---
	// Queue_setVolume :: proc(aQueue: ^Queue, aVolume: f32) ---
	// Queue_setLooping :: proc(aQueue: ^Queue, aLoop: b32) ---
	// Queue_setAutoStop :: proc(aQueue: ^Queue, aAutoStop: b32) ---
	// Queue_set3dMinMaxDistance :: proc(aQueue: ^Queue, aMinDistance: f32, aMaxDistance: f32) ---
	// Queue_set3dAttenuation :: proc(aQueue: ^Queue, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Queue_set3dDopplerFactor :: proc(aQueue: ^Queue, aDopplerFactor: f32) ---
	// Queue_set3dListenerRelative :: proc(aQueue: ^Queue, int aListenerRelative) ---
	// Queue_set3dDistanceDelay :: proc(aQueue: ^Queue, int aDistanceDelay) ---
	// Queue_set3dCollider :: proc(aQueue: ^Queue, aCollider: ^AudioCollider) ---
	// Queue_set3dColliderEx :: proc(aQueue: ^Queue, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Queue_set3dAttenuator :: proc(aQueue: ^Queue, aAttenuator: ^AudioAttenuator) ---
	// Queue_setInaudibleBehavior :: proc(aQueue: ^Queue, aMustTick: b32, aKill: b32) ---
	// Queue_setLoopPoint :: proc(aQueue: ^Queue, double aLoopPoint) ---
	// double Queue_getLoopPoint :: proc(aQueue: ^Queue) ---
	// Queue_setFilter :: proc(aQueue: ^Queue, unsigned int aFilterId, aFilter: ^Filter) ---
	// Queue_stop :: proc(aQueue: ^Queue) ---

	// /*
	//  * RobotizeFilter
	//  */
	// RobotizeFilter_destroy :: proc(RobotizeFilter * aRobotizeFilter) ---
	// int RobotizeFilter_getParamCount :: proc(RobotizeFilter * aRobotizeFilter) ---
	// const char * RobotizeFilter_getParamName :: proc(RobotizeFilter * aRobotizeFilter, unsigned int aParamIndex) ---
	// unsigned int RobotizeFilter_getParamType :: proc(RobotizeFilter * aRobotizeFilter, unsigned int aParamIndex) ---
	// float RobotizeFilter_getParamMax :: proc(RobotizeFilter * aRobotizeFilter, unsigned int aParamIndex) ---
	// float RobotizeFilter_getParamMin :: proc(RobotizeFilter * aRobotizeFilter, unsigned int aParamIndex) ---
	// RobotizeFilter_setParams :: proc(RobotizeFilter * aRobotizeFilter, float aFreq, aWaveform: b32) ---
	// RobotizeFilter * RobotizeFilter_create :: proc() ---

	// /*
	//  * Sfxr
	//  */
	// Sfxr_destroy :: proc(Sfxr * aSfxr) ---
	// Sfxr * Sfxr_create :: proc() ---
	// Sfxr_resetParams :: proc(Sfxr * aSfxr) ---
	// int Sfxr_loadParams :: proc(Sfxr * aSfxr, const char * aFilename) ---
	// int Sfxr_loadParamsMem :: proc(Sfxr * aSfxr, unsigned char * aMem, unsigned int aLength) ---
	// int Sfxr_loadParamsMemEx :: proc(Sfxr * aSfxr, unsigned char * aMem, unsigned int aLength, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// int Sfxr_loadParamsFile :: proc(Sfxr * aSfxr, File * aFile) ---
	// int Sfxr_loadPreset :: proc(Sfxr * aSfxr, int aPresetNo, int aRandSeed) ---
	// Sfxr_setVolume :: proc(Sfxr * aSfxr, aVolume: f32) ---
	// Sfxr_setLooping :: proc(Sfxr * aSfxr, aLoop: b32) ---
	// Sfxr_setAutoStop :: proc(Sfxr * aSfxr, aAutoStop: b32) ---
	// Sfxr_set3dMinMaxDistance :: proc(Sfxr * aSfxr, aMinDistance: f32, aMaxDistance: f32) ---
	// Sfxr_set3dAttenuation :: proc(Sfxr * aSfxr, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Sfxr_set3dDopplerFactor :: proc(Sfxr * aSfxr, aDopplerFactor: f32) ---
	// Sfxr_set3dListenerRelative :: proc(Sfxr * aSfxr, int aListenerRelative) ---
	// Sfxr_set3dDistanceDelay :: proc(Sfxr * aSfxr, int aDistanceDelay) ---
	// Sfxr_set3dCollider :: proc(Sfxr * aSfxr, aCollider: ^AudioCollider) ---
	// Sfxr_set3dColliderEx :: proc(Sfxr * aSfxr, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Sfxr_set3dAttenuator :: proc(Sfxr * aSfxr, aAttenuator: ^AudioAttenuator) ---
	// Sfxr_setInaudibleBehavior :: proc(Sfxr * aSfxr, aMustTick: b32, aKill: b32) ---
	// Sfxr_setLoopPoint :: proc(Sfxr * aSfxr, double aLoopPoint) ---
	// double Sfxr_getLoopPoint :: proc(Sfxr * aSfxr) ---
	// Sfxr_setFilter :: proc(Sfxr * aSfxr, unsigned int aFilterId, aFilter: ^Filter) ---
	// Sfxr_stop :: proc(Sfxr * aSfxr) ---

	/*
				* Speech
				*/
	Speech_destroy :: proc(aSpeech: ^Speech) ---
	Speech_create :: proc() -> ^Speech ---
	Speech_setText :: proc(aSpeech: ^Speech, aText: cstring) -> Result ---
	// int Speech_setParams :: proc(Speech * aSpeech) ---
	// int Speech_setParamsEx :: proc(Speech * aSpeech, unsigned int aBaseFrequency /* = 1330 */, float aBaseSpeed /* = 10.0f */, float aBaseDeclination /* = 0.5f */, int aBaseWaveform /* = KW_TRIANGLE */) ---
	// Speech_setVolume :: proc(Speech * aSpeech, aVolume: f32) ---
	// Speech_setLooping :: proc(Speech * aSpeech, aLoop: b32) ---
	// Speech_setAutoStop :: proc(Speech * aSpeech, aAutoStop: b32) ---
	// Speech_set3dMinMaxDistance :: proc(Speech * aSpeech, aMinDistance: f32, aMaxDistance: f32) ---
	// Speech_set3dAttenuation :: proc(Speech * aSpeech, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Speech_set3dDopplerFactor :: proc(Speech * aSpeech, aDopplerFactor: f32) ---
	// Speech_set3dListenerRelative :: proc(Speech * aSpeech, int aListenerRelative) ---
	// Speech_set3dDistanceDelay :: proc(Speech * aSpeech, int aDistanceDelay) ---
	// Speech_set3dCollider :: proc(Speech * aSpeech, aCollider: ^AudioCollider) ---
	// Speech_set3dColliderEx :: proc(Speech * aSpeech, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Speech_set3dAttenuator :: proc(Speech * aSpeech, aAttenuator: ^AudioAttenuator) ---
	// Speech_setInaudibleBehavior :: proc(Speech * aSpeech, aMustTick: b32, aKill: b32) ---
	// Speech_setLoopPoint :: proc(Speech * aSpeech, double aLoopPoint) ---
	// double Speech_getLoopPoint :: proc(Speech * aSpeech) ---
	// Speech_setFilter :: proc(Speech * aSpeech, unsigned int aFilterId, aFilter: ^Filter) ---
	// Speech_stop :: proc(Speech * aSpeech) ---


	/*
 * TedSid
 */
	// TedSid_destroy :: proc(TedSid * aTedSid) ---
	// TedSid * TedSid_create :: proc() ---
	// int TedSid_load :: proc(TedSid * aTedSid, const char * aFilename) ---
	// int TedSid_loadMem :: proc(TedSid * aTedSid, const unsigned char * aMem, unsigned int aLength) ---
	// int TedSid_loadMemEx :: proc(TedSid * aTedSid, const unsigned char * aMem, unsigned int aLength, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// int TedSid_loadFile :: proc(TedSid * aTedSid, File * aFile) ---
	// TedSid_setVolume :: proc(TedSid * aTedSid, aVolume: f32) ---
	// TedSid_setLooping :: proc(TedSid * aTedSid, aLoop: b32) ---
	// TedSid_setAutoStop :: proc(TedSid * aTedSid, aAutoStop: b32) ---
	// TedSid_set3dMinMaxDistance :: proc(TedSid * aTedSid, aMinDistance: f32, aMaxDistance: f32) ---
	// TedSid_set3dAttenuation :: proc(TedSid * aTedSid, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// TedSid_set3dDopplerFactor :: proc(TedSid * aTedSid, aDopplerFactor: f32) ---
	// TedSid_set3dListenerRelative :: proc(TedSid * aTedSid, int aListenerRelative) ---
	// TedSid_set3dDistanceDelay :: proc(TedSid * aTedSid, int aDistanceDelay) ---
	// TedSid_set3dCollider :: proc(TedSid * aTedSid, aCollider: ^AudioCollider) ---
	// TedSid_set3dColliderEx :: proc(TedSid * aTedSid, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// TedSid_set3dAttenuator :: proc(TedSid * aTedSid, aAttenuator: ^AudioAttenuator) ---
	// TedSid_setInaudibleBehavior :: proc(TedSid * aTedSid, aMustTick: b32, aKill: b32) ---
	// TedSid_setLoopPoint :: proc(TedSid * aTedSid, double aLoopPoint) ---
	// double TedSid_getLoopPoint :: proc(TedSid * aTedSid) ---
	// TedSid_setFilter :: proc(TedSid * aTedSid, unsigned int aFilterId, aFilter: ^Filter) ---
	// TedSid_stop :: proc(TedSid * aTedSid) ---

	// /*
	//  * Vic
	//  */
	// Vic_destroy :: proc(Vic * aVic) ---
	// Vic * Vic_create :: proc() ---
	// Vic_setModel :: proc(Vic * aVic, int model) ---
	// int Vic_getModel :: proc(Vic * aVic) ---
	// Vic_setRegister :: proc(Vic * aVic, int reg, unsigned char value) ---
	// unsigned char Vic_getRegister :: proc(Vic * aVic, int reg) ---
	// Vic_setVolume :: proc(Vic * aVic, aVolume: f32) ---
	// Vic_setLooping :: proc(Vic * aVic, aLoop: b32) ---
	// Vic_setAutoStop :: proc(Vic * aVic, aAutoStop: b32) ---
	// Vic_set3dMinMaxDistance :: proc(Vic * aVic, aMinDistance: f32, aMaxDistance: f32) ---
	// Vic_set3dAttenuation :: proc(Vic * aVic, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Vic_set3dDopplerFactor :: proc(Vic * aVic, aDopplerFactor: f32) ---
	// Vic_set3dListenerRelative :: proc(Vic * aVic, int aListenerRelative) ---
	// Vic_set3dDistanceDelay :: proc(Vic * aVic, int aDistanceDelay) ---
	// Vic_set3dCollider :: proc(Vic * aVic, aCollider: ^AudioCollider) ---
	// Vic_set3dColliderEx :: proc(Vic * aVic, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Vic_set3dAttenuator :: proc(Vic * aVic, aAttenuator: ^AudioAttenuator) ---
	// Vic_setInaudibleBehavior :: proc(Vic * aVic, aMustTick: b32, aKill: b32) ---
	// Vic_setLoopPoint :: proc(Vic * aVic, double aLoopPoint) ---
	// double Vic_getLoopPoint :: proc(Vic * aVic) ---
	// Vic_setFilter :: proc(Vic * aVic, unsigned int aFilterId, aFilter: ^Filter) ---
	// Vic_stop :: proc(Vic * aVic) ---

	// /*
	//  * Vizsn
	//  */
	// Vizsn_destroy :: proc(Vizsn * aVizsn) ---
	// Vizsn * Vizsn_create :: proc() ---
	// Vizsn_setText :: proc(Vizsn * aVizsn, char * aText) ---
	// Vizsn_setVolume :: proc(Vizsn * aVizsn, aVolume: f32) ---
	// Vizsn_setLooping :: proc(Vizsn * aVizsn, aLoop: b32) ---
	// Vizsn_setAutoStop :: proc(Vizsn * aVizsn, aAutoStop: b32) ---
	// Vizsn_set3dMinMaxDistance :: proc(Vizsn * aVizsn, aMinDistance: f32, aMaxDistance: f32) ---
	// Vizsn_set3dAttenuation :: proc(Vizsn * aVizsn, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Vizsn_set3dDopplerFactor :: proc(Vizsn * aVizsn, aDopplerFactor: f32) ---
	// Vizsn_set3dListenerRelative :: proc(Vizsn * aVizsn, int aListenerRelative) ---
	// Vizsn_set3dDistanceDelay :: proc(Vizsn * aVizsn, int aDistanceDelay) ---
	// Vizsn_set3dCollider :: proc(Vizsn * aVizsn, aCollider: ^AudioCollider) ---
	// Vizsn_set3dColliderEx :: proc(Vizsn * aVizsn, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Vizsn_set3dAttenuator :: proc(Vizsn * aVizsn, aAttenuator: ^AudioAttenuator) ---
	// Vizsn_setInaudibleBehavior :: proc(Vizsn * aVizsn, aMustTick: b32, aKill: b32) ---
	// Vizsn_setLoopPoint :: proc(Vizsn * aVizsn, double aLoopPoint) ---
	// double Vizsn_getLoopPoint :: proc(Vizsn * aVizsn) ---
	// Vizsn_setFilter :: proc(Vizsn * aVizsn, unsigned int aFilterId, aFilter: ^Filter) ---
	// Vizsn_stop :: proc(Vizsn * aVizsn) ---

	// /*
	//  * Wav
	//  */
	// Wav_destroy :: proc(Wav * aWav) ---
	// Wav * Wav_create :: proc() ---
	// int Wav_load :: proc(Wav * aWav, const char * aFilename) ---
	// int Wav_loadMem :: proc(Wav * aWav, const unsigned char * aMem, unsigned int aLength) ---
	// int Wav_loadMemEx :: proc(Wav * aWav, const unsigned char * aMem, unsigned int aLength, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// int Wav_loadFile :: proc(Wav * aWav, File * aFile) ---
	// int Wav_loadRawWave8 :: proc(Wav * aWav, unsigned char * aMem, unsigned int aLength) ---
	// int Wav_loadRawWave8Ex :: proc(Wav * aWav, unsigned char * aMem, unsigned int aLength, aSamplerate: f32 /* = 44100.0f */, unsigned int aChannels /* = 1 */) ---
	// int Wav_loadRawWave16 :: proc(Wav * aWav, short * aMem, unsigned int aLength) ---
	// int Wav_loadRawWave16Ex :: proc(Wav * aWav, short * aMem, unsigned int aLength, aSamplerate: f32 /* = 44100.0f */, unsigned int aChannels /* = 1 */) ---
	// int Wav_loadRawWave :: proc(Wav * aWav, float * aMem, unsigned int aLength) ---
	// int Wav_loadRawWaveEx :: proc(Wav * aWav, float * aMem, unsigned int aLength, aSamplerate: f32 /* = 44100.0f */, unsigned int aChannels /* = 1 */, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// double Wav_getLength :: proc(Wav * aWav) ---
	// Wav_setVolume :: proc(Wav * aWav, aVolume: f32) ---
	// Wav_setLooping :: proc(Wav * aWav, aLoop: b32) ---
	// Wav_setAutoStop :: proc(Wav * aWav, aAutoStop: b32) ---
	// Wav_set3dMinMaxDistance :: proc(Wav * aWav, aMinDistance: f32, aMaxDistance: f32) ---
	// Wav_set3dAttenuation :: proc(Wav * aWav, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// Wav_set3dDopplerFactor :: proc(Wav * aWav, aDopplerFactor: f32) ---
	// Wav_set3dListenerRelative :: proc(Wav * aWav, int aListenerRelative) ---
	// Wav_set3dDistanceDelay :: proc(Wav * aWav, int aDistanceDelay) ---
	// Wav_set3dCollider :: proc(Wav * aWav, aCollider: ^AudioCollider) ---
	// Wav_set3dColliderEx :: proc(Wav * aWav, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// Wav_set3dAttenuator :: proc(Wav * aWav, aAttenuator: ^AudioAttenuator) ---
	// Wav_setInaudibleBehavior :: proc(Wav * aWav, aMustTick: b32, aKill: b32) ---
	// Wav_setLoopPoint :: proc(Wav * aWav, double aLoopPoint) ---
	// double Wav_getLoopPoint :: proc(Wav * aWav) ---
	// Wav_setFilter :: proc(Wav * aWav, unsigned int aFilterId, aFilter: ^Filter) ---
	// Wav_stop :: proc(Wav * aWav) ---

	// /*
	//  * WaveShaperFilter
	//  */
	// WaveShaperFilter_destroy :: proc(WaveShaperFilter * aWaveShaperFilter) ---
	// int WaveShaperFilter_setParams :: proc(WaveShaperFilter * aWaveShaperFilter, float aAmount) ---
	// WaveShaperFilter * WaveShaperFilter_create :: proc() ---
	// int WaveShaperFilter_getParamCount :: proc(WaveShaperFilter * aWaveShaperFilter) ---
	// const char * WaveShaperFilter_getParamName :: proc(WaveShaperFilter * aWaveShaperFilter, unsigned int aParamIndex) ---
	// unsigned int WaveShaperFilter_getParamType :: proc(WaveShaperFilter * aWaveShaperFilter, unsigned int aParamIndex) ---
	// float WaveShaperFilter_getParamMax :: proc(WaveShaperFilter * aWaveShaperFilter, unsigned int aParamIndex) ---
	// float WaveShaperFilter_getParamMin :: proc(WaveShaperFilter * aWaveShaperFilter, unsigned int aParamIndex) ---

	// /*
	//  * WavStream
	//  */
	// WavStream_destroy :: proc(WavStream * aWavStream) ---
	// WavStream * WavStream_create :: proc() ---
	// int WavStream_load :: proc(WavStream * aWavStream, const char * aFilename) ---
	// int WavStream_loadMem :: proc(WavStream * aWavStream, const unsigned char * aData, unsigned int aDataLen) ---
	// int WavStream_loadMemEx :: proc(WavStream * aWavStream, const unsigned char * aData, unsigned int aDataLen, int aCopy /* = false */, int aTakeOwnership /* = true */) ---
	// int WavStream_loadToMem :: proc(WavStream * aWavStream, const char * aFilename) ---
	// int WavStream_loadFile :: proc(WavStream * aWavStream, File * aFile) ---
	// int WavStream_loadFileToMem :: proc(WavStream * aWavStream, File * aFile) ---
	// double WavStream_getLength :: proc(WavStream * aWavStream) ---
	// WavStream_setVolume :: proc(WavStream * aWavStream, aVolume: f32) ---
	// WavStream_setLooping :: proc(WavStream * aWavStream, aLoop: b32) ---
	// WavStream_setAutoStop :: proc(WavStream * aWavStream, aAutoStop: b32) ---
	// WavStream_set3dMinMaxDistance :: proc(WavStream * aWavStream, aMinDistance: f32, aMaxDistance: f32) ---
	// WavStream_set3dAttenuation :: proc(WavStream * aWavStream, unsigned int aAttenuationModel, aAttenuationRolloffFactor: f32) ---
	// WavStream_set3dDopplerFactor :: proc(WavStream * aWavStream, aDopplerFactor: f32) ---
	// WavStream_set3dListenerRelative :: proc(WavStream * aWavStream, int aListenerRelative) ---
	// WavStream_set3dDistanceDelay :: proc(WavStream * aWavStream, int aDistanceDelay) ---
	// WavStream_set3dCollider :: proc(WavStream * aWavStream, aCollider: ^AudioCollider) ---
	// WavStream_set3dColliderEx :: proc(WavStream * aWavStream, aCollider: ^AudioCollider, int aUserData /* = 0 */) ---
	// WavStream_set3dAttenuator :: proc(WavStream * aWavStream, aAttenuator: ^AudioAttenuator) ---
	// WavStream_setInaudibleBehavior :: proc(WavStream * aWavStream, aMustTick: b32, aKill: b32) ---
	// WavStream_setLoopPoint :: proc(WavStream * aWavStream, double aLoopPoint) ---
	// double WavStream_getLoopPoint :: proc(WavStream * aWavStream) ---
	// WavStream_setFilter :: proc(WavStream * aWavStream, unsigned int aFilterId, aFilter: ^Filter) ---
	// WavStream_stop :: proc(WavStream * aWavStream) ---
}
