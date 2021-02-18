#!/bin/bash

#################################################
#       __     __  ____             _           #
#      / /__  / /_/ __ )_________ _(_)___  _____#
# __  / / _ \/ __/ __  / ___/ __ `/ / __ \/ ___/#
#/ /_/ /  __/ /_/ /_/ / /  / /_/ / / / / (__  ) #
#\____/\___/\__/_____/_/   \__,_/_/_/ /_/____/  #
#   /   | _____/ /_(_)   ______ _/ /_____  _____#
#  / /| |/ ___/ __/ / | / / __ `/ __/ __ \/ ___/#
# / ___ / /__/ /_/ /| |/ / /_/ / /_/ /_/ / /    #
#/_/  |_\___/\__/_/ |___/\__,_/\__/\____/_/     #
#################################################

####################-脚本预处理-####################
R='\033[1;31m'
G='\033[1;32m'
B='\033[1;36m'
Y='\033[1;33m'
P='\033[1;35m'
N='\033[0m'

echoR(){
	echo -e -n "${R}$1${N}"
}
echoG(){
	echo -e -n "${G}$1${N}"
}
echoB(){
	echo -e -n "${B}$1${N}"
}
echoY(){
	echo -e -n "${Y}$1${N}"
}
echoP(){
	echo -e -n "${P}$1${N}"
}

loginfo(){
	echoB "[info] $1 \xe2\x96\xbc\n"
}
logdone(){
	echoG "[done] $1 \xe2\x88\x9a\n"
}
logwarn(){
	echoY "[warn] $1 \xe2\x9d\x97\n"
}
logerro(){
	echoR "[erro] $1 \xe3\x84\xa8\n"
}
logattr(){
	echoP "[attr] $1 \xe2\x9d\x97\n"
}

count(){
	return $#
}
vertable(){
	#############获取行列#############
	rows=0
	cols=$#
	for argv in "$@" ;do
		count $argv
		argc=$?
		if (( $argc > $rows )) ;then
			rows=$argc
		fi
	done

	r=0;while (( $r<$rows )) ;do
	#############打印顶边#############
		echoB "+"
		for value in "$@" ;do
			lengs=0; for titl in ${value[*]} ;do
				bytes=$[(`echo ${titl} | wc -c`+`echo ${titl} | wc -m`)/2+1]
				if (( $bytes>$lengs )); then
					lengs=$bytes
				fi
			done
			i=0; while (( $i<${lengs} )) ;do
				i=$[$i+1]
				echoG "-"
			done
			echoB "+"
		done
		echoP "\n"

	#############打印内容#############
		echoG "| "
		for value in "$@" ;do
			c=0;for v in ${value[@]} ;do
				if (( $c==$r )) ;then
					echoY "$v"
					lengs=0; for titl in ${value[*]} ;do
						bytes=$[(`echo ${titl} | wc -c`+`echo ${titl} | wc -m`)/2+1]
						if (( $bytes>$lengs )); then
							lengs=$bytes
						fi
					done
					curbytes=$[(`echo ${v} | wc -c`+`echo ${v} | wc -m`)/2+1]
					i=0;for x in ${value[@]} ;do
						if (( $i==$c )) ;then
							n=0;while (( $n<${lengs}-${curbytes} )) ;do
								echoP " "
								n=$[$n+1]
							done
						fi
						i=$[$i+1]
					done

					echoG " | "
				fi
				c=$[$c+1]
			done
		done
		echoP "\n"
	r=$[$r+1];
	done

	#############打印底边#############
	echoB "+"
	for value in "$@" ;do
		lengs=0; for titl in ${value[*]} ;do
			bytes=$[(`echo ${titl} | wc -c`+`echo ${titl} | wc -m`)/2+1]
			if (( $bytes>$lengs )); then
				lengs=$bytes
			fi
		done
		i=0; while (( $i<${lengs} )) ;do
			i=$[$i+1]
			echoG "-"
		done
		echoB "+"
	done
	echo
}

####################-检查系统环境-####################
echo "正在检测终端环境"
srt="\x1b\x5b\x31\x3b\x33\x36\x6d\x74\x65\x73\x74\x1b\x5b\x30\x6d"
dst=`echoB "test" | sed 's/^*test$/done/g' | xxd -ps`

check=`echo -e $dst | xxd -ps -r | cat `
part1=`echo -e -n $srt`
part2=`echo -e -n $check`
if [ ! "$part1" = "$part2" ]; then
	echo "当前终端环境不支持该脚本，请使用Bash运行该脚本."
	exit
fi
logdone "终端环境检测正常"

echoG '\x20\x20\x20\x20\x20\x20\x20\x5f\x5f\x20\x20\x20\x20\x20\x5f\x5f\x20\x20\x5f\x5f\x5f\x5f\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x5f\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20
\x20\x20\x20\x20\x20\x20\x2f\x20\x2f\x5f\x5f\x20\x20\x2f\x20\x2f\x5f\x2f\x20\x5f\x5f\x20\x29\x5f\x5f\x5f\x5f\x5f\x5f\x5f\x5f\x5f\x20\x5f\x28\x5f\x29\x5f\x5f\x5f\x20\x20\x5f\x5f\x5f\x5f\x5f
\x20\x5f\x5f\x20\x20\x2f\x20\x2f\x20\x5f\x20\x5c\x2f\x20\x5f\x5f\x2f\x20\x5f\x5f\x20\x20\x2f\x20\x5f\x5f\x5f\x2f\x20\x5f\x5f\x20\x60\x2f\x20\x2f\x20\x5f\x5f\x20\x5c\x2f\x20\x5f\x5f\x5f\x2f
\x2f\x20\x2f\x5f\x2f\x20\x2f\x20\x20\x5f\x5f\x2f\x20\x2f\x5f\x2f\x20\x2f\x5f\x2f\x20\x2f\x20\x2f\x20\x20\x2f\x20\x2f\x5f\x2f\x20\x2f\x20\x2f\x20\x2f\x20\x2f\x20\x28\x5f\x5f\x20\x20\x29\x20
\x5c\x5f\x5f\x5f\x5f\x2f\x5c\x5f\x5f\x5f\x2f\x5c\x5f\x5f\x2f\x5f\x5f\x5f\x5f\x5f\x2f\x5f\x2f\x20\x20\x20\x5c\x5f\x5f\x2c\x5f\x2f\x5f\x2f\x5f\x2f\x20\x2f\x5f\x2f\x5f\x5f\x5f\x5f\x2f\x20\x20'
echoB '\x0a\x20\x20\x20\x2f\x20\x20\x20\x7c\x20\x5f\x5f\x5f\x5f\x5f\x2f\x20\x2f\x5f\x28\x5f\x29\x20\x20\x20\x5f\x5f\x5f\x5f\x5f\x5f\x20\x5f\x2f\x20\x2f\x5f\x5f\x5f\x5f\x5f\x20\x20\x5f\x5f\x5f\x5f\x5f
\x20\x20\x2f\x20\x2f\x7c\x20\x7c\x2f\x20\x5f\x5f\x5f\x2f\x20\x5f\x5f\x2f\x20\x2f\x20\x7c\x20\x2f\x20\x2f\x20\x5f\x5f\x20\x60\x2f\x20\x5f\x5f\x2f\x20\x5f\x5f\x20\x5c\x2f\x20\x5f\x5f\x5f\x2f
\x20\x2f\x20\x5f\x5f\x5f\x20\x2f\x20\x2f\x5f\x5f\x2f\x20\x2f\x5f\x2f\x20\x2f\x7c\x20\x7c\x2f\x20\x2f\x20\x2f\x5f\x2f\x20\x2f\x20\x2f\x5f\x2f\x20\x2f\x5f\x2f\x20\x2f\x20\x2f\x20\x20\x20\x20
\x2f\x5f\x2f\x20\x20\x7c\x5f\x5c\x5f\x5f\x5f\x2f\x5c\x5f\x5f\x2f\x5f\x2f\x20\x7c\x5f\x5f\x5f\x2f\x5c\x5f\x5f\x2c\x5f\x2f\x5c\x5f\x5f\x2f\x5c\x5f\x5f\x5f\x5f\x2f\x5f\x2f\x20\x20\x20\x20\x20
\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0a'

loginfo "正在检查系统信息"
if [ -f "/bin/uname" ]; then
	if [ `uname -o` = 'GNU/Linux' ]; then
		if [ -f "/etc/redhat-release" ]; then
			sysinfo=`cat /etc/redhat-release`
			logdone "受支持的操作系统 > $sysinfo"
		elif [ -f "/etc/issue.net" ]; then
			sysinfo=`cat /etc/issue.net`
			logdone "受支持的操作系统 > $sysinfo"
		else
			sysinfo=`uname -v`
			logdone "受支持的操作系统 > $sysinfo"
		fi
	else
		logerro "你的操作系统似乎不是GNU/Linux.该脚本目前仅支持GNU/Linux"
		echoY "是否还要继续？ [Y/N]:"
		read ch
		case $ch in
			"y"|"Y")
				logwarn "你正在忽略操作系统检查继续执行脚本"
			;;
			*)
				exit
			;;
		esac
		unset ch
	fi
else
	logerro "你的操作系统似乎连类Unix都不是,这也太扯了!"
	exit
fi

loginfo "正在检查必要的依赖"
if [ ! -f "/bin/curl" ]; then
	if [ ! -f "/usr/bin/curl" ]; then
		if [ ! -f "/bin/wget" ]; then
			if [ ! -f "/usr/bin/wget" ]; then
				logerro "缺少必要依赖：wget 或 curl"
				exit
			fi
		fi
	fi
fi
if [ ! -f "/bin/unzip" ]; then
	if [ ! -f "/usr/bin/unzip" ]; then
		logerro "缺少必要依赖：unzip"
		exit
	fi
fi
logdone "系统包含必要的依赖"

loginfo "正在检查网络连接状况"
ping 47.101.141.156 -c5 > /dev/null>&1
if [ ! $? -eq 0 ]; then
	ping 114.114.114.114 -c1 > /dev/null>&1
	if [ $? -eq 0 ]; then
		logerro "网络连接出错，服务器离线或者正在重启，请稍候重试"
		exit
	fi
	logerro "网络连接出错，请检查你的网络连接"
	exit
fi
logdone "网络连接状况正常"

####################-获取产品信息-####################
loginfo "正在检查系统中包含的Jetbrains产品:"

readonly jb_conf_prefix="$HOME/.config/JetBrains"
readonly jb_cache_prefix="$HOME/.cache/JetBrains"

readonly deskfile=(
	"idea"
	"webstorm"
	"phpstorm"
	"clion"
	"goland"
)
readonly products=(
	"IU"
	"WS"
	"PY"
	"PS"
	"DB"
	"CL"
	"GO"
)

find_home_desk()
{
	desks=$1
	for desk in ${desks[*]} ;do
		files=(
			"$HOME/.local/share/applications/jetbrains-${desk}.desktop"
			"$HOME/.gnome/apps/jetbrains-${desk}.desktop"
			"/usr/share/applications/jetbrains-${desk}.desktop"
			"/usr/local/share/applications/jetbrains-${desk}.desktop"
		)
		for	file in ${files[*]}	;do
			if [ -f "${file}" ]; then
				home_dir=`cat $file | grep Exec= | cut -d\" -f2`; home_dir="${home_dir%bin\/${desk}\.sh*}"
				if [ -d "${home_dir}" ]; then
					case $desk in
						"idea")
							iu_home=$home_dir;
						;;
						"webstorm")
							ws_home=$home_dir;
						;;
						"phpstorm")
							ps_home=$home_dir;
						;;
						"pycharm")
							py_home=$home_dir;
						;;
						"datagrip")
							db_home=$home_dir;
						;;
						"clion")
							cl_home=$home_dir;
						;;
						"goland")
							go_home=$home_dir;
						;;
					esac
					break 1
				fi
			fi
			unset home_dir;
		done
		unset file;
		unset files;
	done
	unset desks;
}
find_home_desk "${deskfile[*]}"

find_home_logs()
{
	pros="$1"
	for pro in ${pros[*]} ;do
		case $pro in
			"IU")
				if [ -d "$iu_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep IntelliJIdea*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f "${file}" ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/idea*}";
					if [[ "$home_dir" =~ "$HOME" ]]; then
						home_dir=`cat $file | grep "Starting file watcher" | tail -n1`;
						home_dir="${home_dir#*Starting\ file\ watcher:\ }"; 
						home_dir="${home_dir%bin\/fsnotifier*}";
					fi
					if [ -d "${home_dir}" ]; then
						iu_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"WS")
				if [ -d "$ws_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep WebStorm*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f "${file}" ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/webstorm*}";
					if [ -d "${home_dir}" ]; then
						ws_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"PY")
				if [ -d "$py_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep PyCharm*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f ${file} ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/pycharm*}";
					if [ -d ${home_dir} ]; then
						py_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"PS")
				if [ -d "$ps_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep PhpStorm*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f ${file} ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/phpstorm*}";
					if [ -d ${home_dir} ]; then
						ps_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"DB")
				if [ -d "$db_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep DataGrip*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f ${file} ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/datagrip*}";
					if [ -d ${home_dir} ]; then
						db_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"CL")
				if [ -d "$cl_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep CLion*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f ${file} ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/clion*}";
					if [ -d ${home_dir} ]; then
						cl_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
			"GO")
				if [ -d "$go_home" ]; then
					continue
				fi

				file=`ls $jb_cache_prefix | grep GoLand*`
				file="$jb_cache_prefix/$file/log/idea.log"
				if [ -f ${file} ]; then
					home_dir=`cat $file | grep Djb.vmOptionsFile | tail -n1`;
					home_dir="${home_dir#*vmOptionsFile=}"; 
					home_dir="${home_dir%bin\/goland*}";
					if [ -d ${home_dir} ]; then
						go_home=$home_dir;
					fi
				fi
				unset home_dir;
			;;
		esac
	done
	unset pros;
}
find_home_logs "${products[*]}"

home_notfound()
{
	if [ -d "${ws_home}" ]; then
		break
	elif [ -d "${ps_home}" ]; then
		break
	elif [ -d "${py_home}" ]; then
		break
	elif [ -d "${db_home}" ]; then
		break
	elif [ -d "${cl_home}" ]; then
		break
	elif [ -d "${go_home}" ]; then
		break
	elif [ -d "${iu_home}" ]; then
		break
	else
		logerro "系统中未找到任何Jetbrains产品"
		exit
	fi
}
home_notfound

find_proinfo()
{
	infos=(
		"$iu_home/product-info.json"
		"$ws_home/product-info.json"
		"$py_home/product-info.json"
		"$ps_home/product-info.json"
		"$db_home/product-info.json"
		"$cl_home/product-info.json"
		"$go_home/product-info.json"
	)

	for info in ${infos[*]}	;do
		if [ -f $info ]; then
			procode=`cat $info | grep \"productCode\": | cut -d\" -f4`
			case ${procode} in
				"IU")
					iu_name=`cat $info | grep \"name\": | cut -d\" -f4 | sed 's/[[:space:]]/_/g'`
					iu_version=`cat $info | grep \"version\": | cut -d\" -f4`
					iu_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					iu_key_path="${jb_conf_prefix}/${iu_data_dir}/idea.key"
				;;
				"WS")
					ws_name=`cat $info | grep \"name\": | cut -d\" -f4`
					ws_version=`cat $info | grep \"version\": | cut -d\" -f4`
					ws_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					ws_key_path="${jb_conf_prefix}/${ws_data_dir}/webstorm.key"
				;;
				"PY")
					py_name=`cat $info | grep \"name\": | cut -d\" -f4`
					py_version=`cat $info | grep \"version\": | cut -d\" -f4`
					py_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					py_key_path="${jb_conf_prefix}/${py_data_dir}/pycharm.key"
				;;
				"PS")
					ps_name=`cat $info | grep \"name\": | cut -d\" -f4`
					ps_version=`cat $info | grep \"version\": | cut -d\" -f4`
					ps_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					ps_key_path="${jb_conf_prefix}/${ps_data_dir}/phpstorm.key"
				;;
				"DB")
					db_name=`cat $info | grep \"name\": | cut -d\" -f4`
					db_version=`cat $info | grep \"version\": | cut -d\" -f4`
					db_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					db_key_path="${jb_conf_prefix}/${db_data_dir}/datagrip.key"
				;;
				"CL")
					cl_name=`cat $info | grep \"name\": | cut -d\" -f4`
					cl_version=`cat $info | grep \"version\": | cut -d\" -f4`
					cl_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					cl_key_path="${jb_conf_prefix}/${cl_data_dir}/clion.key"
				;;
				"GO")
					go_name=`cat $info | grep \"name\": | cut -d\" -f4`
					go_version=`cat $info | grep \"version\": | cut -d\" -f4`
					go_data_dir=`cat $info | grep \"dataDirectoryName\": | cut -d\" -f4`
					go_key_path="${jb_conf_prefix}/${go_data_dir}/goland.key"
				;;
			esac
		fi
	done
	unset infos;
}
find_proinfo "${products[*]}"
logdone "产品检查已完成"

print_proinfo()
{
	title=(
		"产品名称"
		"版本信息"
		"安装目录"
		"密钥路径"
	)
	pros=$1
	for pro in ${pros[*]} ;do
		case $pro in
			"IU")
				if [ -d "$iu_home" ]; then
					productinfo=(
						"${iu_name}"
						"${iu_version}"
						"${iu_home}"
						"${iu_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"WS")
				if [ -d "$ws_home" ]; then
					productinfo=(
						"${ws_name}"
						"${ws_version}"
						"${ws_home}"
						"${ws_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"PY")
				if [ -d "$py_home" ]; then
					productinfo=(
						"${py_name}"
						"${py_version}"
						"${py_home}"
						"${py_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"PS")
				if [ -d "$ps_home" ]; then
					productinfo=(
						"${ps_name}"
						"${ps_version}"
						"${ps_home}"
						"${ps_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"DB")
				if [ -d "$db_home" ]; then
					productinfo=(
						"${db_name}"
						"${db_version}"
						"${db_home}"
						"${db_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"CL")
				if [ -d "$cl_home" ]; then
					productinfo=(
						"${cl_name}"
						"${cl_version}"
						"${cl_home}"
						"${cl_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
			"GO")
				if [ -d "$go_home" ]; then
					productinfo=(
						"${go_name}"
						"${go_version}"
						"${go_home}"
						"${go_key_path}"
					)
					vertable "${title[*]}" "${productinfo[*]}"
				fi
			;;
		esac
	done
	unset pros
}
loginfo "系统中包含下列产品："
print_proinfo "${products[*]}"

####################-获取激活码-####################

loginfo "正在检查工作路径"
workpath="$PWD/.logs"
if [ ! -d "$workpath" ]; then
	mkdir "$workpath";
fi
logdone "工作路径检查完成"

loginfo "正在获取激活码"
ping 47.101.141.156 -c5 > /dev/null>&1
if [ ! $? -eq 0 ]; then
	ping 114.114.114.114 -c1 > /dev/null>&1
	if [ $? -eq 0 ]; then
		logerro "网络连接出错，服务器离线或者正在重启，请稍候重试"
		exit
	fi
	logerro "网络连接出错，请检查你的网络连接"
	exit
fi

if [ -f "/bin/curl" ]; then
	( /bin/curl http://idea.medeming.com/jets/images/jihuoma.zip -o $workpath/activecode.zip )
elif [ -f "/usr/bin/curl" ]; then
	( /usr/bin/curl http://idea.medeming.com/jets/images/jihuoma.zip -o $workpath/activecode.zip )
elif [ -f "/bin/wget" ]; then
	( /bin/wget http://idea.medeming.com/jets/images/jihuoma.zip -O $workpath/activecode.zip )
elif [ -f "/usr/bin/wget" ];then
	( /usr/bin/wget http://idea.medeming.com/jets/images/jihuoma.zip -O $workpath/activecode.zip )
else
	logerro "无法获取激活码，缺少必要依赖：curl 或 wget"
	exit
fi
loginfo "尝试解压激活码"
if [ -f "/bin/unzip" ]; then
	( /bin/unzip "$workpath/activecode.zip" -d $workpath )
elif [ -f "/usr/bin/unzip" ]; then
	( /usr/bin/unzip "$workpath/activecode.zip" -d $workpath )
else
	logerro "无法解压缩激活码，缺少必要依赖：unzip"
	exit
fi
( rm $workpath/*.jpg;rm $workpath/activecode.zip )
( mv $workpath/2018.1* $workpath/2018.1.key;mv $workpath/2017.3* $workpath/2017.3.key; )

if [ -f "$workpath/2018.1.key" ]; then
	if [ -f "$workpath/2017.3.key" ]; then
		logdone "解压激活码完成"
	fi
else
	logerro "解压激活码出错,下载的文件包不完整或服务器出错"
	exit
fi
logdone "获取激活码成功"
####################-处理激活码-####################
loginfo "开始处理激活码"
activecode="$workpath/2018.1.key";
loginfo "加载激活码文件头"
certhead="\xff\xff<\x00c\x00e\x00r\x00t\x00i\x00f\x00i\x00c\x00a\x00t\x00e\x00-\x00k\x00e\x00y\x00>\x00";
loginfo "加载激活码文件"
certkey=`cat $activecode| sed 's#[a-zA-Z0-9=/+-]#&\\\0000#g'`;
logwarn "打印测试信息，如果未出现下列内容则终端环境不支持该脚本"
echo -e $certhead | xxd
echo -e $certkey | xxd | tail -n5
logwarn "如果未出现二进制内容请将脚本在Bash终端运行"
logdone "激活码文件加载完成"
loginfo "正在处理激活码"
hexkey=`echo -e ${certhead} | xxd -ps`
hexkey=$hexkey\x00`echo -e ${certkey} | xxd -ps`
logdone "激活码处理完成"
loginfo "开始写入激活码"
activpro(){
	pros=$1
	for pro in ${pros[*]} ;do
		case $pro in
			"IU")
				if [ -d "$iu_home" ]; then
					iu_major=`echo $iu_version | cut -d\. -f1`
					if (( $iu_major<2018 )); then
						logerro "$iu_name版本过低，当前版本:$iu_version 需要版本大于2018.1"
						unset iu_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${iu_key_path}"
					logdone "写入密钥完成 产品：${iu_data_dir}"
				fi
			;;
			"WS")
				if [ -d "$ws_home" ]; then
					ws_major=`echo $ws_version | cut -d\. -f1`
					if (( $ws_major<2018 )); then
						logerro "$ws_name版本过低，当前版本:$ws_version 需要版本大于2018.1"
						unset ws_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${ws_key_path}"
					logdone "写入密钥完成 产品：${ws_data_dir}"
				fi
			;;
			"PY")
				if [ -d "$py_home" ]; then
					py_major=`echo $py_version | cut -d\. -f1`
					if (( $py_major<2018 )); then
						logerro "$py_name版本过低，当前版本:$py_version 需要版本大于2018.1"
						unset py_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${py_key_path}"
					logdone "写入密钥完成 产品：${py_data_dir}"
				fi
			;;
			"PS")
				if [ -d "$ps_home" ]; then
					ps_major=`echo $ps_version | cut -d\. -f1`
					if (( $ps_major<2018 )); then
						logerro "$ps_name版本过低，当前版本:$ps_version 需要版本大于2018.1"
						unset ps_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${ps_key_path}"
					logdone "写入密钥完成 产品：${ps_data_dir}"
				fi
			;;
			"DB")
				if [ -d "$db_home" ]; then
					db_major=`echo $db_version | cut -d\. -f1`
					if (( $db_major<2018 )); then
						logerro "$db_name版本过低，当前版本:$db_version 需要版本大于2018.1"
						unset db_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${db_key_path}"
					logdone "写入密钥完成 产品：${db_data_dir}"
				fi
			;;
			"CL")
				if [ -d "$cl_home" ]; then
					cl_major=`echo $cl_version | cut -d\. -f1`
					if (( $cl_major<2018 )); then
						logerro "$cl_name版本过低，当前版本:$cl_version 需要版本大于2018.1"
						unset cl_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${cl_key_path}"
					logdone "写入密钥完成 产品：${cl_data_dir}"
				fi
			;;
			"GO")
				if [ -d "$go_home" ]; then
					go_major=`echo $go_version | cut -d\. -f1`
					if (( $go_major<2018 )); then
						logerro "$go_name版本过低，当前版本:$go_version 需要版本大于2018.1"
						unset go_home
						continue
					fi
					echo $hexkey | xxd -ps -r > "${go_key_path}"
					logdone "写入密钥完成 产品：${go_data_dir}"
				fi
			;;
		esac
	done
	unset pros
}
activpro "${products[*]}"
loginfo "已经激活下列产品"
print_proinfo "${products[*]}"
logdone "自动激活完毕."
logattr "如果不生效请手动复制密钥路径下的激活码激活";

####################-事务后处理-####################
(
 rm -r $workpath;
)

