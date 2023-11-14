#!/bin/bash

# 系统终端:1
use_terminal_type=1

# pod命令

pod_liblint="pod lib lint --allow-warnings --verbose --no-clean"
pod_in="pod install"
pod_up="pod update"

function choosList()
{
osascript  <<EOF
    -- 告诉System Events应用程序执行后续的命令
    tell application "System Events"

        -- 激活System Events应用程序，确保选择列表窗口位于前台，并且可以被选中
        activate

        -- 要显示在选择列表中的选项
        set podOptions to {"输入Pod指令", "$pod_in", "pod update", "$pod_liblint"}

        -- 选择列表中默认选中的选项
        set defaultItems to {"pod install"}

        -- 使用上述定义的变量和参数来显示选择列表窗口
        choose from list podOptions with title "$1" with prompt "选择要执行的 Pod 操作: " OK button name "执行" cancel button name "取消" default items defaultItems
    end tell
EOF
}

# 在终端运行
# 参数$1 进入目录
# 参数$2 执行指令
function runPodCommand()
{
    echo "enter runPodCommand function"
    # echo $2
    # 判断指定的终端类型
    case $use_terminal_type in "1") # 系统终端
        echo "选择了系统终端执行"
        runInTerminal "$1" "$2"
        ;;
    "2") # iTerm2

        echo "选择了 iTerm2 终端执行"
        # runInITerm "$1" "$2"
        ;;
    *) # 其它
        message="指定了不支持的终端类型!"
        # showAlert $message "提示" "知道了" "1" "0" "占位" "stop"
        ;;
    esac
}

# 在终端运行
# 参数$1 进入目录
# 参数$2 执行指令
function runInTerminal()
{
# 注意:
# 原本在终端只需执行: "cd $1/..; $2"
# 但是如果 $1 的 path 中如果有文件夹命名中有空格 在终端执行指令就会报 "cd: string not in pwd: XXX/XXX" 的错误 导致无法成功进入文件夹
# 这种情况在 shell 中只需在带空格的文件夹名的空格前面加上 \ 转义即可, 例: /Users/test 2 => /Users/test\ 2
# 但是 此时 shell 是通过 AppleScript 执行的, 如果有 / 会造成 AppleScript 的语法错误,无法执行.
# 在 AppleScript 中添加额外的转义字符，以正确处理具有转义字符的路径和命令.
# 通过修改为: "cd \"$1/..\"; $2" 
# 在此使用了双引号来包裹整个路径。这样可以确保路径中的空格和其他特殊字符被正确解析.
# _path=$(dirname "$1")
_path=$1
echo $2
echo $pod_liblint

case $2 in $pod_liblint)
    _path=$(dirname "$1")
    echo "输出"$_path
    ;;
    "2")
    # echo "命令模式二"
    ;;
    *)
    # echo "其他模式"
esac

osascript <<EOF 
    tell application "Terminal"
        if not (exists window 1) then reopen
        activate
        do script "cd \"$_path/\"; $2" in window 1
    end tell
EOF
}

#获取目录
path=`pwd`
# echo ${path}

# 从路径截取 工程名(带扩展名) 使用 ## 截取, 直到最后一个指定字符（/）再匹配结束
full_name=${path##*/}
# echo $full_name

# 只截取工程名 使用%号截取指定字符（.）左边的所有字符
name="目标:${full_name%.*}"
# echo $path

# 获取命令
pod_command=$(choosList $name)
# echo $pod_command

# 执行pod_command命令
runPodCommand "$path" "$pod_command"
# runPodCommand $path "pod install"
# runInTerminal $path "$pod_command"












