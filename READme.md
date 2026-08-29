# 🚀 Web-Based EXE Runner Pro (3D Accelerated)

基于 Docker + Wine + KasmVNC + Mesa LLVMpipe 构建的高性能网页端 EXE 运行器。专门针对小型 3D 游戏（如 3D SLG、Low-Poly 模拟经营）及中型 Windows 实用工具进行了 CPU 3D 软渲染与图像串流优化。

## 🌟 性能优势
- **KasmVNC 串流引擎**：对比传统 noVNC，帧率大幅提升，支持 WebP 动态压缩与动态分辨率自适应。
- **Mesa LLVMpipe 加速**：启用 CPU 多线程 3D 软渲染（支持 OpenGL 4.5），无显卡环境也能跑小型 3D 游戏。
- **2GB 共享内存**：解决 3D 游戏显存溢出导致的 Docker 容器卡死问题。

## 🛠️ 快速开始

1. 克隆仓库：
   ```bash
   git clone [https://github.com/your-username/web-exe-runner-pro.git](https://github.com/your-username/web-exe-runner-pro.git)
   cd web-exe-runner-pro
