#!/bin/ruby
#-*- coding:utf-8 -*-

#定义程序全局配置
$WORK_PATH		= File.dirname(__FILE__) 				#程序运行目录
$LOGS_PATH		= "#{File.dirname(__FILE__)}/logs/"		#日志文件目录
$MODULE_PATH	= "#{File.dirname(__FILE__)}/modules/"	#模块文件目录
$SCRIPT_PATH	= "#{File.dirname(__FILE__)}/scripts/"	#脚本文件目录
$DATABASE_PATH	= "#{File.dirname(__FILE__)}/database/"	#数据文件目录

#载入工作区间
$LOAD_PATH << $WORK_PATH

#载入模块目录
$LOAD_PATH << $MODULE_PATH

#载入脚本目录
$LOAD_PATH << $SCRIPT_PATH

