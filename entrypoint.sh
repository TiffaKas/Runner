#!/bin/bash
set -e

echo "=========================================================="
echo " Starting Web EXE Runner Pro (Mesa LLVMpipe 3D Accelerated)"
echo "=========================================================="

# 初始化 Wine 环境（防止无头模式卡死）
if [ ! -d "/root/.wine" ]; then
    echo "[+] Initializing Wine 64-bit environment..."
    wineboot --init || true
    # 关闭 Wine 崩溃弹窗以提升性能
    wine reg add "HKCU\Software\Wine\WineDbg" /v ShowCrashDialog /t REG_DWORD /d 0 /f || true
fi

# 启动 Supervisor 管理服务
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
