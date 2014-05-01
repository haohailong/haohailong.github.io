---
layout: page
title: "Notes on Ubuntu"
author: 郝海龙
date: 2014-04-02
comments: true
sharing: true
footer: true
---

## Ubuntu 常用命令备忘

前两天在 Linode 上搭建了 52Podcast 的新博客，搭建的过程中总共系统约 10 次。最后一次搭建的时候，用秒表计时，只用了不到 23 分钟。

在 Linode 上选的系统是 Ubuntu 12.04 LTS，这也是我生平第一次接触 Linux 命令行操作，多少有点不太适应，要知道上一次接触命令行操作还是在用 DOS 的时候（虽然时隔多年又碰到了命令行，我还是不理解为什么初中生要学 DOS）。作为一个外行人，顺便把搭建过程中用到的一些命令放到这里，权做备忘。事实上，这些命令也是 Ubuntu 系统常用命令。

1. 安装命令
	
		apt-get install
		e. g. apt-get install nano, 安装 nano 文本编辑器
		
2. echo 命令
		
		echo
		e. g. echo "www" > /etc/hostname, 把 www 输出到 hostname 文件中。实际效果为重命名 hostname 。
		
3. 升级软件
		
		apt-get update 更新软件源 (/etc/apt/sources.list) 中软件包列表。
		apt-get upgrade 根据上一步操作得到的源软件库与本地已安装软件对比，如果需要就升级。(--show-upgraded)

4. 添加用户 HH，并给 HH 授予 sudo (super do) 权限
		
		adduser HH (此过程会要求创建密码)
		usermod -a -G sudo HH
		passwd 为修改密码命令

5. 生成语言包
		
		locale-gen --lang zh_CN.UTF-8
		
6. 修改某文件权限

		chmod 具体命令比较麻烦，可在使用时查询。

7. 系统服务管理

		service
		e. g. service apache2 restart 重启 apache2
		
8. 下载软件

		wget url
		e. g. wget http://wordpress.org/latest.tar.gz 下载 Wordpress 最新版。

9. 解压缩软件

		tar
		e. g. tar -xzvf latest.tar.gz 
		
10. 复制文件

		cp
		e. g. cp ~/wordpress/wp-config-sample.php ~/wordpress/wp-config.php 复制wp-config-sample.php 到 ~/wordpress/ 目录，并重命名为 wp-config.php
		rsync 命令也经常用于镜像拷贝。
		
11. 切换目录

		cd 后面直接加目录名即可。也可以用 .. 回到上一级目录。
		
12. 其他命令

		mkdir 创建目录，make directory
		ls 列出目录下文件
		rmdir 移除空目录，remove directory
		rm -rf 移除目录及该目录下所有文件及目录
		

