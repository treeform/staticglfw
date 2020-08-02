when defined(emscripten):
  {.passL: "-s USE_WEBGL2=1 -s USE_GLFW=3".}
else:
  when defined(windows):
    when defined(gcc):
      {.passC: "-D_GLFW_WIN32", passL: "-lopengl32 -lgdi32".}
    when defined(vcc):
      {.passC: "-D_GLFW_WIN32".}
      {.link: "kernel32.lib".}
      {.link: "gdi32.lib".}
      {.link: "shell32.lib".}
      {.link: "user32.lib".}
    {.
      compile: "staticglfw/win32_init.c",
      compile: "staticglfw/win32_joystick.c",
      compile: "staticglfw/win32_monitor.c",
      compile: "staticglfw/win32_time.c",
      compile: "staticglfw/win32_thread.c",
      compile: "staticglfw/win32_window.c",
      compile: "staticglfw/wgl_context.c",
      compile: "staticglfw/egl_context.c",
      compile: "staticglfw/osmesa_context.c"
    .}
  elif defined(macosx):
    {.
      passC: "-D_GLFW_COCOA",
      passL: "-framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo",
      compile: "staticglfw/cocoa_init.m",
      compile: "staticglfw/cocoa_joystick.m",
      compile: "staticglfw/cocoa_monitor.m",
      compile: "staticglfw/cocoa_window.m",
      compile: "staticglfw/cocoa_time.c",
      compile: "staticglfw/posix_thread.c",
      compile: "staticglfw/nsgl_context.m",
      compile: "staticglfw/egl_context.c",
      compile: "staticglfw/osmesa_context.c"
    .}
  elif defined(linux):
    {.passL: "-pthread -lGL -lX11 -lXrandr -lXxf86vm -lXi -lXcursor -lm -lXinerama".}

    when defined(wayland):
      {.
        passC: "-D_GLFW_WAYLAND",
        compile: "staticglfw/wl_init.c",
        compile: "staticglfw/wl_monitor.c",
        compile: "staticglfw/wl_window.c",
        compile: "staticglfw/posix_time.c",
        compile: "staticglfw/posix_thread.c",
        compile: "staticglfw/xkb_unicode.c",
        compile: "staticglfw/egl_context.c",
        compile: "staticglfw/osmesa_context.c"
      .}
    else:
      {.
        passC: "-D_GLFW_X11",
        compile: "staticglfw/x11_init.c",
        compile: "staticglfw/x11_monitor.c",
        compile: "staticglfw/x11_window.c",
        compile: "staticglfw/xkb_unicode.c",
        compile: "staticglfw/posix_time.c",
        compile: "staticglfw/posix_thread.c",
        compile: "staticglfw/glx_context.c",
        compile: "staticglfw/egl_context.c",
        compile: "staticglfw/osmesa_context.c"
      .}

    {.compile: "staticglfw/linux_joystick.c".}
  else:
    # If unsupported/unknown OS, use null system
    {.
      compile: "staticglfw/null_init.c",
      compile: "staticglfw/null_monitor.c",
      compile: "staticglfw/null_window.c",
      compile: "staticglfw/null_joystick.c",
      compile: "staticglfw/posix_time.c",
      compile: "staticglfw/posix_thread.c",
      compile: "staticglfw/osmesa_context.c"
    .}

  # Common
  {.
    compile: "staticglfw/context.c",
    compile: "staticglfw/init.c",
    compile: "staticglfw/input.c",
    compile: "staticglfw/monitor.c",
    compile: "staticglfw/vulkan.c",
    compile: "staticglfw/window.c"
  .}

const
  VERSION_MAJOR* = 3
  VERSION_MINOR* = 2
  VERSION_REVISION* = 0

  TRUE* = 1
  FALSE* = 0
  RELEASE* = 0
  PRESS* = 1
  REPEAT* = 2

  # The unknown key
  KEY_UNKNOWN* = - 1
  # Printable keys
  KEY_SPACE* = 32
  KEY_APOSTROPHE* = 39
  KEY_COMMA* = 44
  KEY_MINUS* = 45
  KEY_PERIOD* = 46
  KEY_SLASH* = 47
  KEY_0* = 48
  KEY_1* = 49
  KEY_2* = 50
  KEY_3* = 51
  KEY_4* = 52
  KEY_5* = 53
  KEY_6* = 54
  KEY_7* = 55
  KEY_8* = 56
  KEY_9* = 57
  KEY_SEMICOLON* = 59
  KEY_EQUAL* = 61
  KEY_A* = 65
  KEY_B* = 66
  KEY_C* = 67
  KEY_D* = 68
  KEY_E* = 69
  KEY_F* = 70
  KEY_G* = 71
  KEY_H* = 72
  KEY_I* = 73
  KEY_J* = 74
  KEY_K* = 75
  KEY_L* = 76
  KEY_M* = 77
  KEY_N* = 78
  KEY_O* = 79
  KEY_P* = 80
  KEY_Q* = 81
  KEY_R* = 82
  KEY_S* = 83
  KEY_T* = 84
  KEY_U* = 85
  KEY_V* = 86
  KEY_W* = 87
  KEY_X* = 88
  KEY_Y* = 89
  KEY_Z* = 90
  KEY_LEFT_BRACKET* = 91
  KEY_BACKSLASH* = 92
  KEY_RIGHT_BRACKET* = 93
  KEY_GRAVE_ACCENT* = 96
  KEY_WORLD_1* = 161
  KEY_WORLD_2* = 162
  # Function keys
  KEY_ESCAPE* = 256
  KEY_ENTER* = 257
  KEY_TAB* = 258
  KEY_BACKSPACE* = 259
  KEY_INSERT* = 260
  KEY_DELETE* = 261
  KEY_RIGHT* = 262
  KEY_LEFT* = 263
  KEY_DOWN* = 264
  KEY_UP* = 265
  KEY_PAGE_UP* = 266
  KEY_PAGE_DOWN* = 267
  KEY_HOME* = 268
  KEY_END* = 269
  KEY_CAPS_LOCK* = 280
  KEY_SCROLL_LOCK* = 281
  KEY_NUM_LOCK* = 282
  KEY_PRINT_SCREEN* = 283
  KEY_PAUSE* = 284
  KEY_F1* = 290
  KEY_F2* = 291
  KEY_F3* = 292
  KEY_F4* = 293
  KEY_F5* = 294
  KEY_F6* = 295
  KEY_F7* = 296
  KEY_F8* = 297
  KEY_F9* = 298
  KEY_F10* = 299
  KEY_F11* = 300
  KEY_F12* = 301
  KEY_F13* = 302
  KEY_F14* = 303
  KEY_F15* = 304
  KEY_F16* = 305
  KEY_F17* = 306
  KEY_F18* = 307
  KEY_F19* = 308
  KEY_F20* = 309
  KEY_F21* = 310
  KEY_F22* = 311
  KEY_F23* = 312
  KEY_F24* = 313
  KEY_F25* = 314
  KEY_KP_0* = 320
  KEY_KP_1* = 321
  KEY_KP_2* = 322
  KEY_KP_3* = 323
  KEY_KP_4* = 324
  KEY_KP_5* = 325
  KEY_KP_6* = 326
  KEY_KP_7* = 327
  KEY_KP_8* = 328
  KEY_KP_9* = 329
  KEY_KP_DECIMAL* = 330
  KEY_KP_DIVIDE* = 331
  KEY_KP_MULTIPLY* = 332
  KEY_KP_SUBTRACT* = 333
  KEY_KP_ADD* = 334
  KEY_KP_ENTER* = 335
  KEY_KP_EQUAL* = 336
  KEY_LEFT_SHIFT* = 340
  KEY_LEFT_CONTROL* = 341
  KEY_LEFT_ALT* = 342
  KEY_LEFT_SUPER* = 343
  KEY_RIGHT_SHIFT* = 344
  KEY_RIGHT_CONTROL* = 345
  KEY_RIGHT_ALT* = 346
  KEY_RIGHT_SUPER* = 347
  KEY_MENU* = 348
  KEY_LAST* = KEY_MENU

  MOD_SHIFT* = 0x0001
  MOD_CONTROL* = 0x0002
  MOD_ALT* = 0x0004
  MOD_SUPER* = 0x0008

  MOUSE_BUTTON_1* = 0
  MOUSE_BUTTON_2* = 1
  MOUSE_BUTTON_3* = 2
  MOUSE_BUTTON_4* = 3
  MOUSE_BUTTON_5* = 4
  MOUSE_BUTTON_6* = 5
  MOUSE_BUTTON_7* = 6
  MOUSE_BUTTON_8* = 7
  MOUSE_BUTTON_LAST* = MOUSE_BUTTON_8
  MOUSE_BUTTON_LEFT* = MOUSE_BUTTON_1
  MOUSE_BUTTON_RIGHT* = MOUSE_BUTTON_2
  MOUSE_BUTTON_MIDDLE* = MOUSE_BUTTON_3

  JOYSTICK_1* = 0
  JOYSTICK_2* = 1
  JOYSTICK_3* = 2
  JOYSTICK_4* = 3
  JOYSTICK_5* = 4
  JOYSTICK_6* = 5
  JOYSTICK_7* = 6
  JOYSTICK_8* = 7
  JOYSTICK_9* = 8
  JOYSTICK_10* = 9
  JOYSTICK_11* = 10
  JOYSTICK_12* = 11
  JOYSTICK_13* = 12
  JOYSTICK_14* = 13
  JOYSTICK_15* = 14
  JOYSTICK_16* = 15
  JOYSTICK_LAST* = JOYSTICK_16

  NOT_INITIALIZED* = 0x00010001
  NO_CURRENT_CONTEXT* = 0x00010002
  INVALID_ENUM* = 0x00010003
  INVALID_VALUE* = 0x00010004
  OUT_OF_MEMORY* = 0x00010005
  API_UNAVAILABLE* = 0x00010006
  VERSION_UNAVAILABLE* = 0x00010007
  PLATFORM_ERROR* = 0x00010008
  FORMAT_UNAVAILABLE* = 0x00010009
  NO_WINDOW_CONTEXT* = 0x0001000A

  FOCUSED* = 0x00020001
  ICONIFIED* = 0x00020002
  RESIZABLE* = 0x00020003
  VISIBLE* = 0x00020004
  DECORATED* = 0x00020005
  AUTO_ICONIFY* = 0x00020006
  FLOATING* = 0x00020007
  MAXIMIZED* = 0x00020008
  FOCUS_ON_SHOW* = 0x0002000C

  RED_BITS* = 0x00021001
  GREEN_BITS* = 0x00021002
  BLUE_BITS* = 0x00021003
  ALPHA_BITS* = 0x00021004
  DEPTH_BITS* = 0x00021005
  STENCIL_BITS* = 0x00021006
  ACCUM_RED_BITS* = 0x00021007
  ACCUM_GREEN_BITS* = 0x00021008
  ACCUM_BLUE_BITS* = 0x00021009
  ACCUM_ALPHA_BITS* = 0x0002100A
  AUX_BUFFERS* = 0x0002100B
  STEREO* = 0x0002100C
  SAMPLES* = 0x0002100D
  SRGB_CAPABLE* = 0x0002100E
  REFRESH_RATE* = 0x0002100F
  DOUBLEBUFFER* = 0x00021010

  CLIENT_API* = 0x00022001
  CONTEXT_VERSION_MAJOR* = 0x00022002
  CONTEXT_VERSION_MINOR* = 0x00022003
  CONTEXT_REVISION* = 0x00022004
  CONTEXT_ROBUSTNESS* = 0x00022005
  OPENGL_FORWARD_COMPAT* = 0x00022006
  OPENGL_DEBUG_CONTEXT* = 0x00022007
  OPENGL_PROFILE* = 0x00022008
  CONTEXT_RELEASE_BEHAVIOR* = 0x00022009
  CONTEXT_NO_ERROR* = 0x0002200A
  CONTEXT_CREATION_API* = 0x0002200B

  NO_API* = 0
  OPENGL_API* = 0x00030001
  OPENGL_ES_API* = 0x00030002

  NO_ROBUSTNESS* = 0
  NO_RESET_NOTIFICATION* = 0x00031001
  LOSE_CONTEXT_ON_RESET* = 0x00031002

  OPENGL_ANY_PROFILE* = 0
  OPENGL_CORE_PROFILE* = 0x00032001
  OPENGL_COMPAT_PROFILE* = 0x00032002

  CURSOR* = 0x00033001
  STICKY_KEYS* = 0x00033002
  STICKY_MOUSE_BUTTONS* = 0x00033003

  CURSOR_NORMAL* = 0x00034001
  CURSOR_HIDDEN* = 0x00034002
  CURSOR_DISABLED* = 0x00034003

  ANY_RELEASE_BEHAVIOR* = 0
  RELEASE_BEHAVIOR_FLUSH* = 0x00035001
  RELEASE_BEHAVIOR_NONE* = 0x00035002

  NATIVE_CONTEXT_API* = 0x00036001
  EGL_CONTEXT_API* = 0x00036002

  ARROW_CURSOR* = 0x00036001
  IBEAM_CURSOR* = 0x00036002
  CROSSHAIR_CURSOR* = 0x00036003
  HAND_CURSOR* = 0x00036004
  HRESIZE_CURSOR* = 0x00036005
  VRESIZE_CURSOR* = 0x00036006

  CONNECTED* = 0x00040001
  DISCONNECTED* = 0x00040002

  DONT_CARE* = -1

# GLFW API types
type
  GLProc* = proc() {.cdecl.}
  VKProc* = proc() {.cdecl.}
  Monitor* = pointer
  Window* = pointer
  CursorHandle* = pointer
  ErrorFun* = proc (errorCode: cint, description: cstring) {.cdecl.}
  WindowPosFun = proc (window: Window, x: cint, y: cint) {.cdecl.}
  WindowSizeFun* = proc (window: Window, width: cint, height: cint) {.cdecl.}
  WindowCloseFun* = proc (window: Window) {.cdecl.}
  WindowRefreshFun* = proc (window: Window) {.cdecl.}
  WindowFocusFun* = proc (window: Window, focused: cint) {.cdecl.}
  WindowIconifyFun* = proc (window: Window, iconified: cint) {.cdecl.}
  FrameBufferSizeFun* = proc (window: Window, width: cint, height: cint) {.cdecl.}
  MouseButtonFun* = proc (window: Window, button: cint, action: cint, modifiers: cint) {.cdecl.}
  CursorPosFun* = proc (window: Window, x: cdouble, y: cdouble) {.cdecl.}
  CursorEnterFun* = proc (window: Window, entered: cint) {.cdecl.}
  ScrollFun* = proc (window: Window, xoffset: cdouble, yoffset: cdouble) {.cdecl.}
  KeyFun* = proc (window: Window, key: cint, scancode: cint, action: cint, modifiers: cint) {.cdecl.}
  CharFun* = proc (window: Window, character: cuint) {.cdecl.}
  CharModsFun* = proc (window: Window, codepoint: cuint, mods: cint) {.cdecl.}
  DropFun* = proc (window: Window, count: cint, paths: ptr cstring)
  MonitorFun* = proc (monitor: Monitor, connected: cint) {.cdecl.}
  JoystickFun* = proc (joy : cint, event: cint)

  VidMode* {.pure, final.} = object
    width*: cint
    height*: cint
    redBits*: cint
    greenBits*: cint
    blueBits*: cint
    refreshRate*: cint

  GammaRamp* {.pure, final.} = object
    red*: ptr cushort
    green*: ptr cushort
    blue*: ptr cushort
    size*: cuint

  Image* {.pure, final.} = ptr object
    width: cint
    height: cint
    pixels: seq[byte]

# Methods
proc init*(): cint {.cdecl, importc: "glfwInit".}
proc terminate*() {.cdecl, importc: "glfwTerminate".}
proc getVersion*(major: ptr cint, minor: ptr cint, rev: ptr cint) {.cdecl, importc: "glfwGetVersion".}
proc getVersionString*(): cstring {.cdecl, importc: "glfwGetVersionString".}
proc getRequiredInstanceExtensions*(count: ptr cuint): ptr cstring {.cdecl, importc: "glfwGetRequiredInstanceExtensions".}
proc extensionSupported*(extension: cstring): cint {.cdecl, importc: "glfwExtensionSupported".}
proc getProcAddress*(procname: cstring): GLProc {.cdecl, importc: "glfwGetProcAddress".}
# Cursor functions
proc createCursor*(image: Image, xhot, yhot: cint): CursorHandle {.cdecl, importc: "glfwCreateCursor".}
proc createStandardCursor*(shape: cint): CursorHandle {.cdecl, importc: "glfwCreateStandardCursor".}
proc destroyCursor*(cusor: CursorHandle) {.cdecl, importc: "glfwDestroyCursor".}
# Time functions
proc getTime*(): cdouble {.cdecl, importc: "glfwGetTime".}
proc getTimerFrequency*(): culonglong {.cdecl, importc: "glfwGetTimerFrequency".}
proc getTimerValue*(): culonglong {.cdecl, importc: "glfwGetTimerValue".}
proc swapInterval*(interval: cint) {.cdecl, importc: "glfwSwapInterval".}
proc waitEventsTimeout*(timeout: cdouble) {.cdecl, importc: "glfwWaitEventsTimeout".}
proc setTime*(time: cdouble) {.cdecl, importc: "glfwSetTime".}
# Event functions
proc pollEvents*() {.cdecl, importc: "glfwPollEvents".}
proc postEmptyEvent*() {.cdecl, importc: "glfwPostEmptyEvent".}
proc waitEvents*() {.cdecl, importc: "glfwWaitEvents".}
proc setErrorCallback*(cbfun: ErrorFun): ErrorFun {.cdecl, importc: "glfwSetErrorCallback".}
# Joystick functions
proc joystickPresent*(joy: cint): cint {.cdecl, importc: "glfwJoystickPresent".}
proc getJoystickAxes*(joy: cint, count: ptr cint): ptr cfloat {.cdecl, importc: "glfwGetJoystickAxes".}
proc getJoystickButtons*(joy: cint, count: ptr cint): ptr cuchar {.cdecl, importc: "glfwGetJoystickButtons".}
proc getJoystickName*(joy: cint): cstring {.cdecl, importc: "glfwGetJoystickName".}
proc setJoystickCallback*(cbfun: JoystickFun): JoystickFun {.cdecl, importc: "glfwSetJoystickCallback".}
# monitor functions
proc getMonitors*(count: ptr cint): ptr Monitor {.cdecl, importc: "glfwGetMonitors".}
proc getPrimaryMonitor*(): Monitor {.cdecl, importc: "glfwGetPrimaryMonitor".}
proc getGammaRamp*(monitor: Monitor): ptr GammaRamp {.cdecl, importc: "glfwGetGammaRamp".}
proc getMonitorName*(monitor: Monitor): cstring {.cdecl, importc: "glfwGetMonitorName".}
proc getMonitorPhysicalSize*(monitor: Monitor, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetMonitorPhysicalSize".}
proc getMonitorContentScale*(monitor: Monitor, xscale: ptr cfloat, yscale: ptr cfloat) {.cdecl, importc: "glfwGetMonitorContentScale".}
proc getMonitorPos*(monitor: Monitor, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc: "glfwGetMonitorPos".}
proc getVideoMode*(monitor: Monitor): ptr VidMode {.cdecl, importc: "glfwGetVideoMode".}
proc getVideoModes*(monitor: Monitor, count: ptr cint): ptr VidMode {.cdecl, importc: "glfwGetVideoModes".}
proc setMonitorCallback*(cbfun: MonitorFun): MonitorFun {.cdecl, importc: "glfwSetMonitorCallback".}
proc setGamma*(monitor: Monitor, gamma: cfloat) {.cdecl, importc: "glfwSetGamma".}
proc setGammaRamp*(monitor: Monitor, ramp: ptr GammaRamp) {.cdecl, importc: "glfwSetGammaRamp".}
# Window functions
proc createWindow*(width: cint, height: cint, title: cstring, monitor: Monitor, share: Window): Window{.cdecl, importc: "glfwCreateWindow".}
proc defaultWindowHints*() {.cdecl, importc: "glfwDefaultWindowHints".}
proc destroyWindow*(window: Window) {.cdecl, importc: "glfwDestroyWindow".}
proc focusWindow*(window: Window) {.cdecl, importc: "glfwFocusWindow".}
proc getClipboardString*(window: Window): cstring {.cdecl, importc: "glfwGetClipboardString".}
proc getCursorPos*(window: Window, xpos: ptr cdouble, ypos: ptr cdouble) {.cdecl, importc: "glfwGetCursorPos".}
proc getCurrentContext*(): Window {.cdecl, importc: "glfwGetCurrentContext".}
proc getFramebufferSize*(window: Window, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetFramebufferSize".}
proc getInputMode*(window: Window, mode: cint): cint {.cdecl, importc: "glfwGetInputMode".}
proc getKey*(window: Window, key: cint): cint {.cdecl, importc: "glfwGetKey".}
proc getMouseButton*(window: Window, button: cint): cint {.cdecl, importc: "glfwGetMouseButton".}
proc getWindowAttrib*(window: Window, attrib: cint): cint {.cdecl, importc: "glfwGetWindowAttrib".}
proc getWindowFrameSize*(window: Window, left, top, right, bottom: ptr int) {.cdecl, importc: "glfwGetWindowFrameSize".}
proc getWindowMonitor*(window: Window): Monitor {.cdecl, importc: "glfwGetWindowMonitor".}
proc getWindowPos*(window: Window, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc: "glfwGetWindowPos".}
proc getWindowSize*(window: Window, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetWindowSize".}
proc getWindowUserPointer*(window: Window): pointer {.cdecl, importc: "glfwGetWindowUserPointer".}
proc hideWindow*(window: Window) {.cdecl, importc: "glfwHideWindow".}
proc iconifyWindow*(window: Window) {.cdecl, importc: "glfwIconifyWindow".}
proc makeContextCurrent*(window: Window) {.cdecl, importc: "glfwMakeContextCurrent".}
proc maximizeWindow*(window: Window) {.cdecl, importc: "glfwMaximizeWindow".}
proc restoreWindow*(window: Window) {.cdecl, importc: "glfwRestoreWindow".}
proc setCharCallback*(window: Window, cbfun: CharFun): CharFun {.cdecl, importc: "glfwSetCharCallback".}
proc setCharModsCallback*(window: Window, cbfun: CharModsFun): CharModsFun {.cdecl, importc: "glfwSetCharModsCallback".}
proc setClipboardString*(window: Window, string: cstring) {.cdecl, importc: "glfwSetClipboardString".}
proc setCursor*(window: Window, cursor: CursorHandle) {.cdecl, importc: "glfwSetCursor".}
proc setCursorEnterCallback*(window: Window, cbfun: CursorEnterFun): CursorEnterFun {.cdecl, importc: "glfwSetCursorEnterCallback".}
proc setCursorPos*(window: Window, xpos: cdouble, ypos: cdouble) {.cdecl, importc: "glfwSetCursorPos".}
proc setCursorPosCallback*(window: Window, cbfun: CursorPosFun): CursorPosFun {.cdecl, importc: "glfwSetCursorPosCallback".}
proc setDropCallback*(window: Window, cbfun: DropFun) {.cdecl, importc: "glfwSetDropCallback".}
proc setFramebufferSizeCallback*(window: Window, cbfun: FrameBufferSizeFun): FrameBufferSizeFun {.cdecl, importc: "glfwSetFramebufferSizeCallback".}
proc setInputMode*(window: Window, mode: cint, value: cint) {.cdecl, importc: "glfwSetInputMode".}
proc setKeyCallback*(window: Window, cbfun: KeyFun): KeyFun {.cdecl, importc: "glfwSetKeyCallback".}
proc setMouseButtonCallback*(window: Window, cbfun: MouseButtonFun): MouseButtonFun {.cdecl, importc: "glfwSetMouseButtonCallback".}
proc setScrollCallback*(window: Window, cbfun: ScrollFun): ScrollFun {.cdecl, importc: "glfwSetScrollCallback".}
proc setWindowAspectRatio*(window: Window, numer, denom: cint) {.cdecl, importc: "glfwSetWindowAspectRatio".}
proc setWindowCloseCallback*(window: Window, cbfun: WindowCloseFun): WindowCloseFun {.cdecl, importc: "glfwSetWindowCloseCallback".}
proc setWindowFocusCallback*(window: Window, cbfun: WindowFocusFun): WindowFocusFun {.cdecl, importc: "glfwSetWindowFocusCallback".}
proc setWindowIcon*(window: Window, count: cint, image: Image) {.cdecl, importc: "glfwSetWindowIcon".}
proc setWindowIconifyCallback*(window: Window, cbfun: WindowIconifyFun): WindowIconifyFun {.cdecl, importc: "glfwSetWindowIconifyCallback".}
proc setWindowMonitor*(window: Window, monitor: Monitor, xpos, ypos, width, height: cint) {.cdecl, importc: "glfwSetWindowMonitor".}
proc setWindowPos*(window: Window, xpos: cint, ypos: cint) {.cdecl, importc: "glfwSetWindowPos".}
proc setWindowPosCallback*(window: Window, cbfun: WindowPosFun): WindowPosFun {.cdecl, importc: "glfwSetWindowPosCallback".}
proc setWindowRefreshCallback*(window: Window, cbfun: Windowrefreshfun): Windowrefreshfun {.cdecl, importc: "glfwSetWindowRefreshCallback".}
proc setWindowShouldClose*(window: Window, value: cint) {.cdecl, importc: "glfwSetWindowShouldClose".}
proc setWindowSize*(window: Window, width: cint, height: cint) {.cdecl, importc: "glfwSetWindowSize".}
proc setWindowSizeCallback*(window: Window, cbfun: WindowSizeFun): WindowSizeFun {.cdecl, importc: "glfwSetWindowSizeCallback".}
proc setWindowSizeLimits*(window: Window, minwidth, minheight, maxwidth, maxheight: cint) {.cdecl, importc: "glfwSetWindowSizeLimits".}
proc setWindowTitle*(window: Window, title: cstring) {.cdecl, importc: "glfwSetWindowTitle".}
proc setWindowUserPointer*(window: Window, pointer: pointer) {.cdecl, importc: "glfwSetWindowUserPointer".}
proc showWindow*(window: Window) {.cdecl, importc: "glfwShowWindow".}
proc swapBuffers*(window: Window) {.cdecl, importc: "glfwSwapBuffers".}
proc windowShouldClose*(window: Window): cint {.cdecl, importc: "glfwWindowShouldClose".}
proc windowHint*(target: cint, hint: cint) {.cdecl, importc: "glfwWindowHint".}

# Vulkan types & functions
when defined(vulkanTypes):
    type 
      VkInstance* = pointer
      VkPhysicalDevice* = pointer
      VkAllocationCallbacks* = pointer
      VkSurfaceKHR* = pointer
      VkResult* = enum
        VK_ERROR_FRAGMENTED_POOL = -12
        VK_ERROR_FORMAT_NOT_SUPPORTED = -11
        VK_ERROR_TOO_MANY_OBJECTS = -10
        VK_ERROR_INCOMPATIBLE_DRIVER = -9
        VK_ERROR_FEATURE_NOT_PRESENT = -8
        VK_ERROR_EXTENSION_NOT_PRESENT = -7
        VK_ERROR_LAYER_NOT_PRESENT = -6
        VK_ERROR_MEMORY_MAP_FAILED = -5
        VK_ERROR_DEVICE_LOST = -4
        VK_ERROR_INITIALIZATION_FAILED = -3
        VK_ERROR_OUT_OF_DEVICE_MEMORY = -2
        VK_ERROR_OUT_OF_HOST_MEMORY = -1
        VK_SUCCESS = 0
        VK_NOT_READY = 1
        VK_TIMEOUT = 2
        VK_EVENT_SET = 3
        VK_EVENT_RESET = 4
        VK_INCOMPLETE = 5

proc vulkanSupported*(): cint {.cdecl, importc: "glfwVulkanSupported".}
proc getInstanceProcAddress*(instance: VkInstance, procname: cstring): VKProc {.cdecl, importc: "glfwGetInstanceProcAddress".}
proc getPhysicalDevicePresentationSupport*(instance: VkInstance, device: VkPhysicalDevice, queuefamily: cuint): cint {.cdecl, importc: "glfwGetPhysicalDevicePresentationSupport".}
proc createWindowSurface*(instance: VkInstance, window: Window, allocator: ptr VkAllocationCallbacks, surface: ptr VkSurfaceKHR): VkResult {.cdecl, importc: "glfwCreateWindowSurface".}
