#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#
# 跟LEDE的不一样，19.07源码编译成功后就不需要登录密码的，所以不需要设置密码为空
#


# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.5.1/g' ./package/base-files/files/bin/config_generate


#内核版本是会随着源码更新而改变的，在Lienol/openwrt的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile就可以查看源码正在使用什么内核
#修改版本内核（19.07默认使用4.14内核，还有4.19跟4.9的内核，自行选择。这个跟LEDE的有点不一样，这个是修改一行代码的）
#sed -i 's/KERNEL_PATCHVER:=4.14/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本


#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
#git clone -b master https://github.com/vernesong/OpenClash.git package/diy/luci-app-openclash  #openclash出国软件
#git clone https://github.com/frainzy1477/luci-app-clash.git package/diy/luci-app-clash  #clash出国软件
#git clone https://github.com/tty228/luci-app-serverchan.git package/diy/luci-app-serverchan  #微信推送
#git clone https://github.com/jerrykuku/node-request.git package/diy/node-request  #京东签到依赖
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/diy/luci-app-jd-dailybonus  #京东签到
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-filetransfer package/diy/luci-app-filetransfer  #文件传输（可用于安装IPK）

#使用LEDE的ShadowSocksR Plus+出国软件 (源码自带passwall出国软件)
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/diy/luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/tcping package/diy/tcpping
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev package/diy/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt package/diy/pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks package/diy/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dns2socks package/diy/dns2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/simple-obfs package/diy/simple-obfs
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray-plugin package/diy/v2ray-plugin
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray package/diy/v2ray
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/trojan package/diy/trojan
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipt2socks package/diy/ipt2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/diy/redsocks2

# 注释掉lienol大luci(dev-17.01)源
sed -i 's/^\(.*luci\)/#&/' feeds.conf.default

# 添加lienol大luci(dev-18.06)源
sed -i '$a src-git luci https://github.com/Lienol/openwrt-luci.git;dev-18.06' feeds.conf.default

# 删除原版smartdns插件
#rm -rf package/feeds/packages/smartdns
#rm -rf feeds/packages/net/smartdns

# 拉取smartdns插件
#svn co https://github.com/coolsnowwolf/packages/trunk/net/smartdns package/lienol/smartdns

# 删除源码argon主题，替换成最新的argon主题
rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
#全新的[argon-主题]登录界面,图片背景跟随Bing.com，每天自动切换
#增加可自定义登录背景功能，可用WinSCP将文件上传到/www/luci-static/argon/background 目录下，支持jpg png gif格式图片
#主题将会优先显示自定义背景，多个背景为随机显示，系统默认依然为从bing获取
#增加了可以强制锁定暗色模式的功能，如果需要，请登录ssh 输入：touch /etc/dark 即可开启，关闭请输入：rm -rf /etc/dark，关闭后颜色模式为跟随系统

