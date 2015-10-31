# Path to your oh-my-zsh installation.
export ZSH=/home/hzc/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump mvn gradle adb)

# User configuration

export PATH="/home/hzc/program/hadoop/infra-client/bin:/home/hzc/program/android-ndk-r10c:/usr/lib/jvm/java/jdk1.6.0_37/bin:/usr/lib/jvm/java/jdk1.6.0_37/jre/bin:/home/hzc/program/android-sdk-linux/platform-tools:/home/hzc/program/android-sdk-linux/tools:/home/hzc/program/mistudio2/bin:/home/hzc/bin:/home/hzc/program/apache-maven-3.2.5/bin":$PATH

export ANT_HOME=/home/hzc/program/apache-ant-1.9.6
export PAHT=$ANT_HOME:$PATH

export JAVA_HOME=/usr/lib/jvm/java/jdk1.6.0_37


# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias dd='date +"%F,%T" -d'
alias ggi='grep --color=auto -r -i'
alias pidcat='python ~/tools/pidcat.py'
alias nsd='DISPLAY=:0.0 notify-send -t 2000'
alias alog='adb logcat | grep -i'


alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf' 




#own functions
function logvoip() 
{
    pidcat com.miui.voip 
}

function log()
{
    pidcat $1
}

function clearcontacts() 
{
	adb shell rm -rf /data/data/com.android.contacts/shared_prefs/
	adb shell rm -rf /data/data/com.android.providers.contacts/shared_prefs/
	killtag acore
}


function meminfo()
{
    adb shell dumpsys meminfo $1
}


function procrank()
{
    adb shell procrank
}

 
function backup()
{
    tar jcvfh $1-`date +%F_%H-%M`.tar.bz2 $1
}
 

function ff()
{
    find . | grep -i --color "$@"
}

function clearVoip() {
    adb root ; adb remount ; adb shell rm -rf /data/data/com.miui.voip/shared_prefs ; adb shell rm -rf /data/data/com.miui.voip/app_tone; adb shell rm -rf /data/data/com.miui.voip/cache ; adb shell rm -rf /data/data/com.miui.voip/files ; killtag voip ;
}

function gpull()
{
    git pull --rebase
}

function pulldb()
{
    adb pull /data/data/"$1"/databases ./
}

function pulldbFcard()
{
    adb pull /sdcard/MiuiVoip ./
}

function go()
{
    if [ "$#" -gt 0 ]; then
       mkdir $1
       cd $1
    else
       var=`date +%m%d`
       mkdir $var
       cd $var
    fi
}

function gomytmp()
{
    cd ~/tmp/
    if [ "$#" -gt 0 ]; then
       rm -rf $1
       mkdir $1
       cd $1
    else
       var=`date +%m%d`
       rm -rf $var
       mkdir $var
       cd $var
    fi
}

function lunchcancro() {
	. build/envsetup.sh
	lunch cancro-eng
	source ~/.zshrc
}

function mmit()
{
	mm -B
	mit;
}


function mit()
{
	killtag voip
	adb root
	adb remount
	adb push ../../../out/target/product/cancro/system/priv-app/MiuiVoip.apk /system/priv-app
#	adb push $MIUIVOIP /system/priv-app
	sleep 3
	killtag voip
	killtag systemui
}



function checkalpha() {
	cd /home/hzc/develop/kk-miui6/
	cd miui/frameworks/base
	git checkout v6-alpha
	cd ../telephony/base
	git checkout v6-alpha
	cd ../../opt/telephony
	git checkout v6-alpha
	cd ../../../../frameworks/base
	git checkout v6-kk-cancro-alpha
	cd ../../packages/apps/MiuiVoip
	git checkout v6-alpha
	cd ../../../
}

function checkdev() {
	cd /home/hzc/develop/kk-miui6/
	cd miui/frameworks/base
	git checkout v6-dev
	cd ../telephony/base
	git checkout v6-dev
	cd ../../opt/telephony
	git checkout v6-dev
	cd ../../../../frameworks/base
	git checkout v6-kk-cancro-dev
	cd ../../packages/apps/MiuiVoip
	git checkout v6-dev
	cd ../../../
}

function makealpha() 
{
	checkalpha;
	make MiuiVoip -j4
	mit;
}


function makedev() 
{
	checkdev;
	make MiuiVoip -j4
	mit;
}

function mmpit() 
{
	mm -B;
	mpit
}

function mpit() 
{
	killtag voip
	adb root
	adb remount
	adb push ../../../out/target/product/cancro/system/priv-app/MiuiVoip.apk /system/priv-app/MiuiVoip
#	adb push $MIUIVOIP /system/priv-app/MiuiVoip
	sleep 3
	killtag voip
	killtag systemui
}

function chgjdk17()
{
	export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
	export JRE_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
	export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH
	export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
}

function chgjdk16() 
{
	export JAVA_HOME=/usr/lib/jvm/java/jdk1.6.0_37
	export JRE_HOME=/usr/lib/jvm/java/jdk1.6.0_37/jre
	export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH
	export PATH=/usr/lib/jvm/java/jdk1.6.0_37/bin:/usr/lib/jvm/java/jdk1.6.0_37/jre/bin:$PATH
}

function getscreenshots()
{
	adb pull /sdcard/DCIM/ScreenShots ./
}



function cira()
{
    echo '=========================='
    echo
    echo 'what in xmsf folder now'
    adb shell ls /data/data/com.xiaomi.xmsf
    echo
    echo 'now trying to delete xmsf/databases'
    adb shell rm -rf /data/data/com.xiaomi.xmsf/databases/
    echo
    echo 'now trying to delete xmsf/shared_prefs/pref_activate.xml'
    adb shell rm /data/data/com.xiaomi.xmsf/shared_prefs/pref_activate.xml
    echo
    echo 'what in xmsf folder now'
    adb shell ls /data/data/com.xiaomi.xmsf
    echo
    echo '=========================='
    echo
    echo 'what process is com.xiaomi.xmsf now'
    adb shell ps | grep com.xiaomi.xmsf
    echo
    echo 'now trying to kill xmsf'
    adb shell busybox killall com.xiaomi.xmsf
    echo
    echo 'what process is com.xiaomi.* now'
    adb shell ps | grep com.xiaomi.xmsf
    echo
    echo '=========================='
    echo
    echo 'what process is com.android.mms now'
    adb shell ps | grep com.android.mms
    echo
    echo 'now trying to kill mms'
    adb shell busybox killall com.android.mms
    adb shell busybox killall com.android.mms.service
    echo
    echo 'what process is com.android.mms now'
    adb shell ps | grep com.android.mms
    echo
    echo '=========================='
}

#kill 杀掉device process
#tag process name
function killtag() {
    adb shell ps|grep -i "$@" |awk '{print $2}' > ~/tmp.txt
    echo "kill pid : $(cat ~/tmp.txt)"
    adb shell kill -9 $(cat ~/tmp.txt)
    rm -rf ~/tmp.txt
}

#autojump
[[ -s /home/hzc/.autojump/etc/profile.d/autojump.sh ]] && source /home/hzc/.autojump/etc/profile.d/autojump.sh

MIUIVOIP=/home/hzc/develop/kk-miui6/out/target/product/cancro/system/priv-app/MiuiVoip.apk
