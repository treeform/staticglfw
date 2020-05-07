import opengl, staticglfw

# Init GLFW
if init() == 0:
  raise newException(Exception, "Failed to Initialize GLFW")

# Open window.
var window = createWindow(800, 600, "GLFW3 WINDOW", nil, nil)
# Connect the GL context.
window.makeContextCurrent()
# This must be called to make any GL function work
loadExtensions()

# Run while window is open.
while windowShouldClose(window) == 0:

  # Draw red color screen.
  glClearColor(1, 0, 0, 1)
  glClear(GL_COLOR_BUFFER_BIT)

  # Swap buffers (this will display the red color)
  window.swapBuffers()

  # Check for events.
  pollEvents()
  # If you get ESC key quit.
  if window.getKey(KEY_ESCAPE) == 1:
    window.setWindowShouldClose(1)

# Destroy the window.
window.destroyWindow()
# Exit GLFW.
terminate()
