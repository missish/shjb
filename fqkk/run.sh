owsq(){
ou=$(echo $owsq | grep -o "uin.*" | cut -d '&' -f1 | cut -d '=' -f2)
key=$(echo $owsq | grep -o "key.*" | cut -d '&' -f1 | cut -d '=' -f2)
ov=$(echo $owsq | grep -o "version.*" | cut -d '&' -f1 | cut -d '=' -f2)
op=$(echo $owsq | grep -o "pass_ticket.*" | cut -d ' ' -f1 | cut -d '=' -f2)
if [ $(echo $ou | grep -c "%3D%3D") -eq 1 ]
then ou=$(echo $ou | cut -d '%' -f1 | sed 's/$/&==/g' )
aou=$(echo $ou | cut -d '=' -f1 | sed 's/$/&%3D%3D/g')
else aou=$ou
fi
}
fqrw(){
url=$(curl -Ls "http://m.oo2u4.cn/entry" | grep -o "url_h5 =.*" | grep -o "：.*" | grep -o "[a-z0-9:./-]*")
rk=$(curl -s "$url" | grep -o "get('.*" | cut -d "'" -f2)
rw=$(curl -s "$rk" -H "User-Agent:$ua" | grep -o "http.*" | cut -d '/' -f3 | cut -d '\' -f1)
}
fqzlm(){
if [ ! -z $zlm ]
then zlg=$(curl -s "http://$rw/zs?for=$zlm" -H "User-Agent:$ua" -H "Cookie:$ck" | grep -o 'background)".*' | cut -d '>' -f2 | cut -d '<' -f1)
if [ ! -z $zlg ]
then zlg=为$zlg助力，
else dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt 助力码无效，如需助力请重新运行脚本并输入正确的助力码 > ckerror
fi
fi
}
fqfr(){
fqfr=$(curl -s "http://$rw/fast_reada" -H "User-Agent:$ua" -H "Cookie:$ck")
if [ $(echo $fqfr | grep -c 'userinfo-score"') -eq 1 ]
then b=$(echo $fqfr | grep -o 'userinfo-score".*' | cut -d ':' -f2 | cut -d '<' -f1)
[ $(echo $b | grep -c ".") -eq 1 ] && b=$(echo $b | cut -d '.' -f1)
a=$(($b/100))
zz=$(($b%100))
[ $zz -lt 10 ] && c=0$zz || c=$zz
y=$a.$c
un=$(echo $fqfr | grep -o 'userinfo-name".*' | cut -d '<' -f1 | cut -d '>' -f2)
else dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt ck无效，请重新运行脚本并输入新的常量 > ckerror
fi
}
fqrft(){
if [ ! -s ckerror ]
then fqrft=$(curl -s -d "readLastKey=" "http://$rw/reada/finishTask" -H "X-Requested-With: XMLHttpRequest" -H "User-Agent:$ua" -H "Cookie:$ck")
if [ $(echo $fqrft | grep -c "data") -eq 1 ]
then n=$(echo $fqrft | grep -o "num.*" | cut -d ',' -f1 | cut -d '"' -f3)
[ -z $n ] && n=0
if [ $n -eq 0 ]
then dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt 今日阅读次数为0，请先手动阅读1次进行微信授权 > ckerror
fi
s=$(echo $fqrft | grep -o "score.*" | cut -d ',' -f1 | cut -d '"' -f3)
[ -z $s ] && s=0
rest=$(echo $fqrft | grep -o "rest.*" | cut -d ',' -f1 | cut -d ':' -f2)
[ $(echo $fqrft | grep -c "msg") -eq 0 ] && status=1 || status=$(echo $fqrft | grep -o "status.*" | cut -d ',' -f1 | cut -d ':' -f2)
if [ $status -eq 1 ]
then msg1=$(echo $fqrft | grep -o "msg.*" | cut -d '"' -f3 | cut -d '<' -f1)
msg2=$(echo $fqrft | grep -o "msg.*" | cut -d '>' -f2 | cut -d '<' -f1)
msg3=$(echo $fqrft | grep -o "msg.*" | cut -d '>' -f3 | cut -d '"' -f1)
msg=$(echo $msg1$msg2$msg3)
else msg=$(echo $fqrft | grep -o "msg.*" | cut -d '"' -f3)
fi
dt=$(date '+%Y-%m-%d %H:%M:%S')
rft=$(echo $dt $un$zlg今日已阅读$n次，今日总奖励$s币，本小时剩余未阅读$rest次，当前$y可提现 $msg)
else dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt ck无效，请重新运行脚本并输入新的常量 > ckerror
fi
fi
}
fqfrdr(){
[ ! -z $zlm ] && zs=1
r=$(awk 'BEGIN{srand();printf "%.16f\n",rand()}')
fqfrdr=$(curl -s "http://$rw/fast_reada/do_read?for=$zlm&zs=$zs&pageshow&r=$r&jkey=$jkey" -H "User-Agent:$ua" -H "X-Requested-With: XMLHttpRequest" -H "Cookie:$ck")
if [ $(echo $fqfrdr | grep -c '"jkey"') -eq 1 -a $(echo $fqfrdr | grep -c "oauth2") -eq 1 ]
then jkey=$(echo $fqfrdr | grep -o "jkey.*" | cut -d '"' -f3)
ja=$(echo $fqfrdr | grep -o "appid.*" | cut -d '&' -f1 | cut -d '=' -f2)
ju=$(echo $fqfrdr | grep -o "uri.*" | cut -d "%" -f4 | cut -c 3-)
ji=$(echo $fqfrdr | grep -o "%3D.*" | cut -d '&' -f1 | cut -c 4-)
js=$(echo $fqfrdr | grep -o "state.*" | cut -d '&' -f1 | cut -d '=' -f2)
else jkey=
fi
drm=$(echo $fqfrdr | grep -o "msg.*" | cut -d '"' -f3)
}
owa(){
uuid=$(curl -s -H "user-agent:$ua" --compressed "https://open.weixin.qq.com/connect/oauth2/authorize?appid=$ja&redirect_uri=http%3A%2F%2F$ju%2Ffast_reada%2Foiejr%3Fjumpid%3D$ji&response_type=code&scope=snsapi_userinfo&state=$js&connect_redirect=1&uin=$aou&key=$key&version=$ov&pass_ticket=$op" | grep -o "&uuid.*" | cut -d '&' -f2 | cut -d '=' -f2)
if [ -z $uuid ]
then dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt owsq常量失效，请重新运行脚本并输入新的owsq > ckerror
fi
}
owar(){
owar=$(curl -ski "https://open.weixin.qq.com/connect/oauth2/authorize_reply?allow=1&snsapi_userinfo=on&uuid=$uuid&uin=$ou&key=$key&pass_ticket=$op&version=$ov" -H "User-Agent:$ua")
jc=$(echo "$owar" | grep -o "code.*" | cut -d '&' -f1 | cut -d '=' -f2)
}
joj(){
joj=$(curl -ski "http://$ju/fast_reada/oiejr?jumpid=$ji&code=$jc&state=$js" -H "User-Agent:$ua" -H "Cookie:$ck")
rw=$(echo "$joj" | grep -o "Location:.*" | cut -d '/' -f3)
}
roj(){
roj=$(curl -ski "http://$rw/fast_reada/oiejr?jumpid=$ji&code=$jc&state=$js" -H "User-Agent:$ua" -H "Cookie:$ck")
}
djs(){
for ((i=10;i>0;i--))
do
clear
echo "$rft
阅读中，等待$i秒"
sleep 1
done
echo $drm
}
rm -rf ckerror
read -p "请输入ck: " ck
read -p "请输入ua: " ua
read -p "请输入owsq: " owsq
read -p "请输入助力码，不需要助力则回车: " zlm
owsq
fqrw
fqfr
fqzlm
fqrft
while sleep 0
do
if [ ! -s ckerror ]
then if [ $status -ne 4 -a $status -ne 2 -a $rest -ne 0 ]
then fqfrdr
owa
owar
joj
roj
djs
fqrft
clear
echo $rft
fi
else clear
echo $(cat ckerror)
fi
done
