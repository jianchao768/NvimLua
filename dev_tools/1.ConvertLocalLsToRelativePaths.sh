#!/bin/bash

# 用于将家目录的mason 软连接转换为相对路径
# 主要用 ln -sfnr 实现。
# 设置 Mason 根目录
MASON_ROOT="$HOME/.local/share/nvim/mason"

if [ -d "$MASON_ROOT" ]; then
    echo "开始递归处理目录: $MASON_ROOT"
    
    # 使用 find 查找目录下所有的软链接 (-type l)
    # 使用 while read 确保处理带有空格的文件名
    find "$MASON_ROOT" -type l | while read -r link; do
        
        # 1. 获取链接指向的【最终真实物理目标】
        # 使用 readlink -f 会追踪到底，防止出现链接套链接的情况
        target=$(readlink -f "$link")
        
        # 2. 检查目标是否依然在 Mason 文件夹内
        # 我们只希望修复 Mason 内部的相互引用，不希望把指向系统（如 /bin/sh）的链接也改了
        if [[ "$target" == "$MASON_ROOT"* ]]; then
            # 3. 强制转换为相对路径链接
            # -s: symbolic link
            # -f: force (覆盖旧链接)
            # -n: 把指向目录的链接视为普通文件（防止某些极端情况下的嵌套）
            # -r: relative (关键！自动计算相对路径)
            ln -sfnr "$target" "$link"
            
            echo "已转换: ${link#$MASON_ROOT/} -> $(readlink "$link")"
        else
            echo "跳过外部链接: ${link#$MASON_ROOT/} -> $target"
        fi
    done
    
    echo "---"
    echo "所有 Mason 内部链接已转换为相对路径，现在可以随意移动整个目录了。"
else
    echo "错误: 找不到目录 $MASON_ROOT"
fi
