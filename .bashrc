

resetup(){
        #auto source global setup.zsh
        printf "%-40s " "sourcing /opt/ros/humble/setup.zsh"
        if [ -e "/opt/ros/humble/setup.zsh" ]
        then
                source /opt/ros/humble/setup.zsh
                if [ $? ]
                then
                                result="[OK]"
                else
                                result="[Failed]"
                fi
        else
                result="[Not Found]"
        fi
        printf "%-5s\n" "$result"
        # try to sourcing local_setup
        printf "%-40s " "sourcing local_setup.zsh"
        if [ -e "install/local_setup.zsh" ]
        then
                pushd install > /dev/null
                source local_setup.zsh
                if [ $? ]
                then
                        result="[OK]"
                else
                        result="[Failed]"
                fi
                popd > /dev/null
        else
                result="[Not found]"
        fi
        printf "%-5s\n" "$result"
}
# auto detect ros_workspace
if [ -e "install/local_setup.bash" ]
then
        read -n 1 -p "source local_setup.bash(y / n default)? " str
        echo "\r"
        if [ -n $str ]
        then
                if [ $str = 'y' -o $str = 'Y' ]
                then
                        resetup
                fi
        fi
fi








export MVCAM_SDK_PATH=/opt/MVS

export MVCAM_COMMON_RUNENV=/opt/MVS/lib

export MVCAM_GENICAM_CLPROTOCOL=/opt/MVS/lib/CLProtocol

export ALLUSERSPROFILE=/opt/MVS/MVFG
export LD_LIBRARY_PATH=/opt/MVS/lib/aarch64:$LD_LIBRARY_PATH
