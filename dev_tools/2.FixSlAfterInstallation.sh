#!/bin/bash

# 用于安装完成之后修复 ~/.local/nvim/share/mason/ 下的软连接
# 具体：简单替换掉旧软连接的家目录前缀
#   自动获取当前机器的 Mason 根目录
#   假设你的整合包放在标准的 nvim 数据目录下
MASON_ROOT="$HOME/.local/share/nvim/mason"

echo "开始智能修复 Mason 软链接..."
echo "当前家目录: $HOME"

# 2. 递归查找所有软链接
find "$MASON_ROOT" -type l | while read -r link; do
    # 获取原始链接指向的【绝对路径】
    old_target=$(readlink "$link")
    
    # 核心逻辑：如果路径中包含 ".local/share/nvim/mason"
    if [[ "$old_target" == *".local/share/nvim/mason"* ]]; then
        
        # 提取从 .local 开始及其之后的所有内容
        # 这一步去掉了旧的 /home/username 部分
        suffix="${old_target#*.local/share/nvim/mason}"
        
        # 拼接到当前机器的路径上
        new_target="$MASON_ROOT$suffix"
        
        # 如果新路径确实存在，且与旧路径不同，则执行修复
        if [ "$old_target" != "$new_target" ]; then
            ln -sf "$new_target" "$link"
            echo "已修正: $(basename "$link")"
            echo "   从: $old_target"
            echo "   到: $new_target"
        fi
    fi
done

echo "修复完成！"
