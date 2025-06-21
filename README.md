## Flutter Custom Fragment Shaders - Liquid glass

https://github.com/user-attachments/assets/ee6d54e9-0188-4260-a096-682bec62a796

### Introduction

Fragment shaders in Flutter allow you to create stunning visual effects by writing code that runs directly on the GPU. This guide will walk you through creating a liquid glass effect with touch interaction, explaining every step of the process.

### What are Fragment Shaders?

Fragment shaders are small programs that run on the GPU to determine the color of each pixel on the screen. Unlike traditional Flutter widgets that are computed on the CPU, shaders leverage the parallel processing power of graphics cards for smooth, complex visual effects. Shaders have many benefits:

* Performance: GPU parallel processing
* Visual Quality: Complex effects impossible with widgets
* Smooth Animation: 60+ FPS even with complex calculations
* Creative Freedom: Unlimited visual possibilities

### How Shaders Work

```
Flutter Widget Tree → Skia/Impeller Rendering → GPU → Fragment Shader → Final Pixels

```

1. Widget Layer: Flutter builds widget tree
2. Skia Layer: Converts to drawing commands
3. GPU Layer: Executes shader for each pixel
4. Output: Final rendered frame

### References

- [Flutter Shaders Documentation](https://docs.flutter.dev/ui/design/graphics/fragment-shaders)

- [Flutter Build Show - Custom Fragment Shaders](https://www.youtube.com/watch?v=OpcPZdfJbq8)

- [Flutter liquid glass update plan](https://github.com/flutter/flutter/issues/170310#issuecomment-2959275864)

