#!/bin/bash
if [ `id -u` -ne 0 ]; then
    echo "--- 请切换成root用户后重新执行 ---"
    exit 1
fi
echo "--- --- --- --- 注意事项 --- --- --- ---"
echo "请务必将此脚本放于jdk tar包同一目录，并赋予本脚本执行权限"
echo "本脚本仅适用于tar.gz打包的jdk包，且务必将要安装的jdk包重命名为jdk.tar.gz"
echo "--- --- --- --- 安装开始 --- --- --- ---"
while ((1))
do
    echo "1. 安装"
    echo "2. 卸载"
    read -p "请选择: " i
    case "$i" in
    1)
        echo "安装开始---"
        if [ ! -d "jdk" ]; then
            if [ ! -e "jdk.tar.gz" ]; then
                echo "jdk.tar.gz文件不存在"
                echo "安装已中止，请仔细阅读注意事项并重试,by chin"
            else
                mkdir ./jdk && tar -xzvf jdk.tar.gz -C ./jdk --strip-components 1
            fi
        else
            echo "已存在jdk解压后的目录，是否略去解压，开始安装？"
            while ((1))
            do
                echo "1. 略去解压，继续安装"
                echo "2. 重新解压，继续安装"
                read -p "请选择: " i
                case "$i" in
                1)
                    echo "--- 开始安装 ---"
                    exit 1
                ;;
                2)
                    rm -r jdk
                    mkdir ./jdk && tar -xzvf jdk.tar.gz -C ./jdk --strip-components 1
                    break
                ;;
                *)
                    echo "输入有误，重新输入"
                esac
            done
        fi
        cp -r jdk /opt/
        cd /
        if [ ! -e "/etc/profile.chin" ]; then
            cp /etc/profile /etc/profile.chin
            echo "/etc/profile已备份为/etc/profile.chin"
        fi
        echo '' >> /etc/profile
        echo '#jdk' >> /etc/profile
        echo 'export JAVA_HOME=/opt/jdk' >> /etc/profile
        echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${PATHCLASS}' >> /etc/profile
        echo 'export PATH=.:${JAVA_HOME}/bin:${PATH}' >> /etc/profile
        source /etc/profile
        echo "安装已完成，请重启,by chin"
        exit 1
    ;;
    2)
        echo "仅支持卸载本脚本安装的java，是否继续"
        while ((1))
        do
            echo "1. 是"
            echo "2. 否"
            read -p "请选择: " i
            case "$i" in
            1)
                echo "--- 开始卸载 ---"
                if [  -d "jdk" ]; then
                    rm -r jdk
                fi
                if [  -d "/opt/jdk" ]; then
                    rm -r /opt/jdk
                fi
                if [ ! -e "/etc/profile.chin" ]; then
                    echo "备份文件/etc/profile.chin不存在，请自行修改/etc/profile"
                else
                    rm /etc/profile
                    mv /etc/profile.chin /etc/profile
                fi
                echo "--- 卸载完成 ---"
                exit 1
            ;;
            2)
                echo "--- 已终止卸载 ---"
                exit 1
            ;;
            *)
                echo "输入有误，重新输入"
            esac
        done
    ;;
    *)
        echo "输入有误，重新输入"
    esac
done