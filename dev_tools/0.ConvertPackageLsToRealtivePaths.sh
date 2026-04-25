#!/bin/bash

# 只将开发包的mason下面软连接替换为相对路径，不更改本机配置

# 1. 定义你存放离线包副本的 Mason 路径
OFFLINE_MASON="$HOME/Downloads/NvimLua/.local/share/nvim/mason"

# 2. 定义原系统的 Mason 路径特征（用于识别哪些链接需要修复）
# 通常 Mason 的路径里都包含这个固定段
PATH_PATTERN="/.local/share/nvim/mason/"

echo "开始全量修复离线包内的所有软链接..."

if [ ! -d "$OFFLINE_MASON" ]; then
    echo "错误: 找不到目录 $OFFLINE_MASON"
    exit 1
fi

# 3. 递归处理所有软链接
find "$OFFLINE_MASON" -type l | while read -r link; do
    
    # 获取目前的指向（目前它可能指向你原系统的绝对路径）
    old_target=$(readlink "$link")
    
    # 4. 判定逻辑：如果链接目标包含 Mason 的路径特征
    if [[ "$old_target" == *"$PATH_PATTERN"* ]]; then
        
        # 核心提取：只保留路径中从 /.local/share/nvim/mason/ 之后的部分
        # 这样无论旧路径前面是 /home/user 还是 /root，都能被剔除
        suffix="${old_target#*$PATH_PATTERN}"
        
        # 重新拼接：将其指向你当前 Download 目录副本里的对应实体文件
        new_target="$OFFLINE_MASON/$suffix"
        
        # 5. 执行转换：
        # -sfnr 会计算当前 $link 和 $new_target 的相对偏移
        # 从而生成诸如 ../../packages/... 这种在包内跳转的相对链接
        ln -sfnr "$new_target" "$link"
        
        echo "✅ 已修复: ${link#$OFFLINE_MASON/}"
        # 取消注释下面这行可以查看具体的相对指向变化
        # echo "   指向 -> $(readlink "$link")"
    else
        # 如果链接指向系统目录（如 /lib 或 /usr），则保持原样
        echo "ℹ️ 跳过外部链接: ${link#$OFFLINE_MASON/}"
    fi
done

echo "---"
echo "所有 Mason 内部链接已修正为【相对路径】。现在你可以安全地将 $OFFLINE_MASON 迁移到离线机器上了。"
