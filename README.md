## Flutter Custom Fragment Shaders - Liquid glass

https://github.com/user-attachments/assets/ee6d54e9-0188-4260-a096-682bec62a796

### 🎯 Giới thiệu

Fragment Shader trong Flutter được viết bằng GLSL (OpenGL Shading Language), một ngôn ngữ lập trình chuyên dụng cho đồ họa máy tính. 
- Đây là những chương trình nhỏ chạy trên GPU để xác định màu sắc của từng pixel trên màn hình. 
- Không giống như các widget Flutter truyền thống được tính toán trên CPU, shader tận dụng sức mạnh xử lý song song của card đồ họa để tạo ra các hiệu ứng thị giác mượt mà và phức tạp.

### Shaders hoạt động như nào ?

```
Flutter Widget Tree → Skia/Impeller Rendering → Canvas -> GPU → Fragment Shader → Final Pixels
```

1. Widget Layer: Flutter builds widget tree
2. Skia/Impeller Layer: Converts to drawing commands
3. GPU Layer: Executes shader for each pixel
4. Output: Final rendered frame

Nếu chưa rõ về cách mà flutter rendering, hãy xem lại ở [đây](./Rendering.md)

### Template

Hãy tưởng tượng bạn có 1 triệu người thợ vẽ (GPU cores):
- Mỗi người chịu trách nhiệm vẽ 1 pixel
- Tất cả đều làm việc CÙNG LÚC
- Mỗi người đều làm theo cùng 1 "công thức" (shader code)
- Kết quả: 1 triệu pixels được vẽ đồng thời!

~~~glsl
#version 460 core

// INPUT: Dữ liệu từ Flutter
uniform float uTime;        // Thời gian (animation)
uniform vec2 uResolution;   // Kích thước màn hình
uniform vec2 uMouse;        // Vị trí chuột (nếu có)

// INPUT: Từ vertex shader
in vec2 fragCoord;         // Tọa độ pixel hiện tại

// OUTPUT: Màu sắc pixel
out vec4 fragColor;        // RGBA color

// MAIN FUNCTION: Logic shader
void main() {
    // 1. Normalize tọa độ (0.0 đến 1.0)
    vec2 uv = fragCoord / uResolution;
    
    // 2. Tính toán màu sắc cho pixel này
    vec3 color = calculatePixelColor(uv);
    
    // 3. Output màu cuối cùng
    fragColor = vec4(color, 1.0);
}
~~~

#### Ví dụ 1: Gradient đơn giản

~~~glsl
#version 460 core

uniform vec2 uResolution;
out vec4 fragColor;

void main() {
    // 1. Normalize coordinates
    vec2 uv = gl_FragCoord.xy / uResolution;
    
    // 2. Create horizontal gradient
    // uv.x = 0.0 (trái) đến 1.0 (phải)
    float gradientFactor = uv.x;
    
    // 3. Mix colors based on position
    vec3 leftColor = vec3(1.0, 0.0, 0.0);   // Red
    vec3 rightColor = vec3(0.0, 0.0, 1.0);  // Blue
    
    vec3 finalColor = mix(leftColor, rightColor, gradientFactor);
    
    // 4. Output
    fragColor = vec4(finalColor, 1.0);
}
~~~

### Tham khảo

- [Flutter Shaders Documentation](https://docs.flutter.dev/ui/design/graphics/fragment-shaders)

- [Flutter Build Show - Custom Fragment Shaders](https://www.youtube.com/watch?v=OpcPZdfJbq8)

- [Flutter liquid glass update plan](https://github.com/flutter/flutter/issues/170310#issuecomment-2959275864)

