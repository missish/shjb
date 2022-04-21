cl(){
stty -echo
read -p "慎用，注销后无法恢复，只能重新获取
请输入青龙常量，格式为
ip:端口或青龙地址@client_id@client_secret
后悔的话直接回车: " qlcl
stty echo
host=$(echo $qlcl | cut -d '@' -f1)
client_id=$(echo $qlcl | cut -d '@' -f2)
client_secret=$(echo $qlcl | cut -d '@' -f3)
[ ! -z $qlcl ] && tk
}
tk(){
tk=$(curl -s -X GET -H "Host:$host" -H "User-Agent:Mozilla/5.0 (Linux; Android 10; V1838T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.104 Mobile Safari/537.36" "http://$host/open/auth/token?client_id=$client_id&client_secret=$client_secret")
tt=$(echo $tk | grep -o "token_type.*" | cut -d '"' -f3)
tk=$(echo $tk | grep -o "token.*" | cut -d '"' -f3)
qck="$tt $tk"
message=$(echo $tk | grep -o "message.*" | cut -d '"' -f3)
[ -z $tk ] && echo $message请检查青龙常量$qlcl || echo 青龙token获取成功
}
zx(){
if [ ! -z $tk ]
then ev
zs=$(echo $ev | jq | grep -o "pt_key.*" | cut -d ";" -f1 | wc -l)
read -p "慎用，现在后悔还来得及，检测到当前青龙有$zs个ptkey，注销后无法恢复，只能重新获取，确认注销请输入y: " zx
if [ "$zx" = "y" -o "$zx" = "Y" ]
then if [ $(command -v jq | grep -c "jq") -lt 1 ]
then yum update || apt update
yes | yum upgrade || yes | apt upgrade
yum update || apt update
yum install jq -y || apt install jq -y
fi
e=$((zs+1))
for ((s=1; s<e; s++))
do
ptkey=$(echo $ev | jq | grep -o "pt_key.*" | cut -d ";" -f1 | sed -n "$s"p)
curl -s -X GET -H "Host:plogin.m.jd.com" -H "user-agent:Mozilla/5.0 (Linux; Android 10; FRL-AN00a Build/HUAWEIFRL-AN00a; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/88.0.4324.93 Mobile Safari/537.36 hap/1080/huawei com.huawei.fastapp/11.6.1.301 com.jd.quickApp/2.2.3 ({"packageName":"search","type":"url","extra":"{}"})" -H "cookie:$ptkey" "https://plogin.m.jd.com/cgi-bin/ml/mlogout"
sleep 0
done
echo 注销完成，我可是提醒过你哈，不能怪我
fi
fi
}
ev(){
t=$(expr $(date +%s%N) / 1000000)
ev=$(curl -s -X GET -H "Host:$host" -H "User-Agent:Mozilla/5.0 (Linux; Android 10; V1838T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.104 Mobile Safari/537.36" -H "Authorization:$qck" "http://$host/open/envs?searchValue=&t=$t")
}
cl && zx
