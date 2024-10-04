#!/bin/bash

# 创建保存截图的目录
path="/sdcard/0-daily/"
mkdir -p $path

# 无限循环，每60秒截一次图
while true; do
    # 获取当前小时
    current_hour=$(date +%H)

    # 如果时间在凌晨4点到上午10点之间（04:00到10:00），跳过截图
    if [ "$current_hour" -ge 4 ] && [ "$current_hour" -lt 10 ]; then
        echo "现在是凌晨4点到上午10点之间，暂停截图。"
        sleep 60  # 暂停1分钟，然后再次检查时间
        continue
    fi

    # 获取当前时间的秒数，用于计算到下一个整分钟的秒数
    current_seconds=$(date +%s)
    # 计算下一个整分钟的时间戳
    next_minute=$(( (current_seconds / 60 + 1) * 60 ))
    # 计算等待秒数
    wait_seconds=$(( next_minute - current_seconds ))
    
    echo "等待 $wait_seconds 秒"
    
    # 等待到下一个整分钟
    sleep $wait_seconds

    # 获取当前时间并生成文件名，格式为“3日22时22分55秒.png”
    filename=$(date +"%d日%H时%M分%S秒").png
    
    # 截图并保存到指定路径
    echo "保存截图为: $filename"
    adb exec-out screencap -p > "$path/$filename"
done