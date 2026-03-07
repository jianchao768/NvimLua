#!/bin/bash

set -e

BASE_BACKUP_DIR="$HOME/tmp_config"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$BASE_BACKUP_DIR/$TIMESTAMP"

echo "开始安装配置..."

mkdir -p "$BACKUP_DIR"

backup_if_exist() {
  set +x
  local target="$1"
  if [ -e "$target" ]; then
    local rel_path="${target#$HOME/}"  # 去掉 $HOME/ 前缀
    local backup_path="$BACKUP_DIR/$rel_path"

    echo "___ 检测到 $target 已存在，移动到备份目录 $backup_path"

    mkdir -p "$(dirname "$backup_path")"
    mv "$target" "$backup_path"
  fi
  set -x
}


set -x
# 1. 备份并复制 .bashrc
backup_if_exist "$HOME/.bashrc"
cp .bashrc "$HOME/"

# 2. 备份并复制 .fzf.bash
backup_if_exist "$HOME/.fzf.bash"
cp .fzf.bash "$HOME/"

# 3. 解压 fzf.tar.xz 到家目录
backup_if_exist "$HOME/.fzf"
tar -xJf fzf.tar.xz -C "$HOME"

# 4. 备份并复制 nvim 配置
backup_if_exist "$HOME/.config/nvim"
mkdir -p "$HOME/.config"
cp -r .config/nvim "$HOME/.config/"

# 5. 备份并复制 nvim 配置
backup_if_exist "$HOME/.config/lib/"
mkdir -p "$HOME/.config"
cp -r .config/lib/ "$HOME/.config/"

# 6. 备份并复制 .local/share 目录下的内容（备份整个 ~/.local/share）
#backup_if_exist "$HOME/.local/share/fonts/"  -- 暂时不备份，防止删除原有字体
backup_if_exist "$HOME/.local/share/nvim/"
mkdir -p "$HOME/.local/share"
cp -r .local/share/fonts "$HOME/.local/share/"
cp -r .local/share/nvim "$HOME/.local/share/"

tar -xJf ~/.local/share/fonts/UbuntuMono/UbuntuMono.tar.xz -C ~/.local/share/fonts/UbuntuMono/
tar -xJf ~/.local/share/nvim/lazy.tar.xz -C ~/.local/share/nvim/

# 7. 恢复clangd 
cat ~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd.tar.xz.part_a* > ~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd.tar.xz
tar -xJf ~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd.tar.xz -C ~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/

ln -sf ~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd ~/.local/share/nvim/mason/bin/clangd
ln -sf ~/.local/share/nvim/mason/packages/clangd/mason-schemas/lsp.json   ~/.local/share/nvim/mason/share/mason-schemas/lsp/clangd.json

# ---------------------------------------------------------------------------------------------------------------------
# 8. 添加定时清理 lsp.log，防止占用过多内存
cp -r .config/logrotate.d/ "$HOME/.config/"

JOB="0 3 * * * $(command -v logrotate) -s \$HOME/.local/state/logrotate.status \$HOME/.config/logrotate.d/nvim"

CRON="$(crontab -l 2>/dev/null || true)"

if ! printf "%s\n" "$CRON" | grep -qxF "$JOB"; then
  (printf "%s\n" "$CRON"; printf "%s\n" "$JOB") | crontab -
fi
# ---------------------------------------------------------------------------------------------------------------------

set +x

echo "配置安装完成！备份文件在 $BACKUP_DIR"
echo
echo "请执行以下命令刷新环境："
echo
echo "    source ~/.bashrc"
