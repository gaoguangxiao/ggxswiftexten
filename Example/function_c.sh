#检测指令
pod_liblint="pod lib lint --allow-warnings --verbose --no-clean"


# 检测指令和目录的合法性，如果指令为验证，则需要查询验证所需要执行的目录，返回返回合理的路径，默认返回$1
# $1 路径
# $2 命令
# 只能返回整数
function checkPodCommand(){
    _path=$1
    _podcommand=$2

case $_podcommand in $pod_liblint)
    _path=$(dirname "$_path")
    # return ${_path}
;;

"2")
echo "命令模式二"
;;

*)
echo "其他模式"

esac

return 4
}

#获取目录
path=`pwd`

# checkPodCommand "$path" "$pod_liblint"
poExecute=$(checkPodCommand "$path" "$pod_liblint")

echo "可执行路径："${poExecute}





# echo "路径-----"${t}
