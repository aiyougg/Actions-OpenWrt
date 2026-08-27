#!/bin/bash

set -e

OPENWRT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
QOSMATE_DIR="$OPENWRT_DIR/package/luci-app-qosmate"

echo "========================================"
echo "   luci-app-qosmate 自动更新"
echo "========================================"

if [ ! -d "$QOSMATE_DIR/.git" ]; then
    echo "错误：找不到 Git 仓库："
    echo "$QOSMATE_DIR"
    exit 1
fi

cd "$QOSMATE_DIR"

# 检查本地是否有未提交修改
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "错误：luci-app-qosmate 存在本地修改："
    git status --short
    echo
    echo "请先执行："
    echo "git restore ."
    exit 1
fi

echo "[1/3] 获取 GitHub 最新 Tag..."

git fetch --tags --force origin

# 获取最新正式 Tag
LATEST_TAG="$(
    git tag --list 'v[0-9]*' --sort=-version:refname |
    grep -Ev -- '-(alpha|beta|rc|pre)[0-9]*$' |
    head -n 1
)"

if [ -z "$LATEST_TAG" ]; then
    echo "错误：没有找到正式版本 Tag"
    exit 1
fi

LATEST_VERSION="${LATEST_TAG#v}"

CURRENT_TAG="$(git describe --tags --exact-match 2>/dev/null || true)"

echo "当前版本：${CURRENT_TAG:-非 Tag}"
echo "最新版本：$LATEST_TAG"

echo
echo "[2/3] 切换版本..."

if [ "$CURRENT_TAG" = "$LATEST_TAG" ]; then
    echo "已经是最新版本，无需切换。"
else
    git checkout --quiet "$LATEST_TAG"
    echo "已切换到 $LATEST_TAG"
fi

echo
echo "[3/3] 同步 OpenWrt PKG_VERSION..."

# 仅修改本地 Makefile，不提交到 Git
sed -i "s/^PKG_VERSION:=.*/PKG_VERSION:=$LATEST_VERSION/" Makefile

echo "PKG_VERSION:=$LATEST_VERSION"

echo
echo "========================================"
echo "更新完成"
echo "========================================"
echo "Git Tag       : $LATEST_TAG"
echo "PKG_VERSION   : $LATEST_VERSION"
echo
echo "注意：这里只更新 luci-app-qosmate，"
echo "不会编译 OpenWrt，也不会处理 qosmate 后端。"
