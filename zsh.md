
# zsh安装
`sudo apt install zsh`

# 设置代理
ip替换为自己的ip
```sh
export http_proxy=http://192.168.1.1:10809
export https_proxy=http://192.168.1.1:10809
```
# ohmyzsh安装

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# ohmyzsh插件安装

1. zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
2. zsh-autosuggestions
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
3. zsh-completions
```sh
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```

# 安装power10k主题

```
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

# zsh配置文件修改

```sh
ZSH_THEME="powerlevel10k/powerlevel10k"
#......
plugins=(git sudo z zsh-completions zsh-autosuggestions zsh-syntax-highlighting extract)
#zsh-completions config before source onmyzsh
#在sourcing ohmyzsh之前配置fpath
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
```

# ros 环境配置
> 添加到`.zshrc`最前面
复制后面的
```zsh
resetup(){
        #pushd install > /dev/null
        source /opt/ros/humble/setup.zsh
        if [ $? ]
        then
                result="[OK]"
        else
                result="[Failed]"
        fi
        printf "%-40s %-5s\n" "sourcing /opt/ros/humble/setup.zsh" "$result"
        #popd > /dev/null
        #source local_setup
        if [ -e "install/local_setup.bash" ]
        then
                pushd install > /dev/null
                source local_setup.zsh
                if [ $? ]
                then
                        result="[OK]"
                else
                        result="[Failed]"
                fi
                printf "%-40s %-5s\n" "sourcing local_setup.zsh" "$result"
                #if [ $? ];then printf "%-40s %-5s\n" "sourcing local_setup.zsh" "[OK]";fi
                popd > /dev/null
        else
                echo "no install/local_setup.zsh found"
        fi
}
#auto source ros2 if avaliable in shell start
if [ -e "install/local_setup.bash" ]
then
        read -k 1 "s?source local_setup.bash(default y / n)? "
        echo "\r"
        if [ -n $s ]
        then
                if [ $s == 'y' -o $s == 'Y' ]
                then
                        resetup
                fi
        fi
fi
```

bash的:
```bash
resetup(){
        #pushd install > /dev/null
        source /opt/ros/humble/setup.bash
        if [ $? ]
        then
                result="[OK]"
        else
                result="[Failed]"
        fi
        printf "%-40s %-5s\n" "sourcing /opt/ros/humble/setup.bash" "$result"
        #popd > /dev/null
        #source local_setup
        if [ -e "install/local_setup.bash" ]
        then
                pushd install > /dev/null
                source local_setup.bash
                if [ $? ]
                then
                        result="[OK]"
                else
                        result="[Failed]"
                fi
                printf "%-40s %-5s\n" "sourcing local_setup.bash" "$result"
                #if [ $? ];then printf "%-40s %-5s\n" "sourcing local_setup.zsh" "[OK]";fi
                popd > /dev/null
        else
                echo "no install/local_setup.bash found"
        fi
}
#auto source ros2 if avaliable in shell start
if [ -e "install/local_setup.bash" ]
then
        read -k 1 "s?source local_setup.bash(y / n default)? "
        echo "\r"
        if [ -n $s ]
        then
                if [ $s == 'y' -o $s == 'Y' ]
                then
                        resetup
                fi
        fi
fi
```

移除缩进和注释（会自动添加缩进）：
```sh
resetup(){
source /opt/ros/humble/setup.zsh
if [ $? ]
then
result="[OK]"
else
result="[Failed]"
fi
printf "%-40s %-5s\n" "sourcing /opt/ros/humble/setup.zsh" "$result"
if [ -e "install/local_setup.bash" ]
then
pushd install > /dev/null
source local_setup.zsh
if [ $? ]
then
result="[OK]"
else
result="[Failed]"
fi
printf "%-40s %-5s\n" "sourcing local_setup.zsh" "$result"
popd > /dev/null
else
echo "no install/local_setup.zsh found"
fi
}
if [ -e "install/local_setup.bash" ]
then
read -k 1 "s?source local_setup.bash(default y / n)? "
echo "\r"
if [ -n $s ]
then
if [ $s == 'y' -o $s == 'Y' ]
then
resetup
fi
fi
fi
```
MVS和其他配置，放在最下面：
```zsh
alias temp1="sudo cat /sys/class/thermal/thermal_zone1/temp"
alias temp0="sudo cat /sys/class/thermal/thermal_zone0/temp"
alias vnc=tigervncserver -localhost no
#MVCAM_SDK export
export MVCAM_SDK_PATH=/opt/MVS
export MVCAM_COMMON_RUNENV=/opt/MVS/lib
export MVCAM_GENICAM_CLPROTOCOL=/opt/MVS/lib/CLProtocol
export ALLUSERSPROFILE=/opt/MVS/MVFG
export LD_LIBRARY_PATH=/opt/MVS/lib/aarch64:$LD_LIBRARY_PATH
```
