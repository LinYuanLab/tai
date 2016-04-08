#!/bin/ruby
#-*- coding:utf-8 -*-

#定义程序全局配置
$WORK_PATH		= File.dirname(__FILE__) 				#程序运行目录
$LOGS_PATH		= "#{$WORK_PATH}/logs"		#日志文件目录
$PROC_PATH		= "#{$WORK_PATH}/proc"		#扫描进程目录
$TASK_PATH      = "#{$WORK_PATH}/scans"		#扫描结果目录
$RULE_PATH		= "#{$WORK_PATH}/rules"		#规则文件目录
$HTTP_ROOT      = "#{$WORK_PATH}/web"		#WEB框架目录
$MODULE_PATH	= "#{$WORK_PATH}/modules"	#模块文件目录
$SCRIPT_PATH	= "#{$WORK_PATH}/scripts"	#脚本文件目录
$DATABASE_PATH	= "#{$WORK_PATH}/database"	#数据库文件目录


#http服务相关
$HTTP_HOST      = "localhost"
$HTTP_PORT      = 80
$HTTP_VIEW      = "#{$HTTP_ROOT}/views/"

#载入工作区间
$LOAD_PATH << $WORK_PATH
#载入模块目录
$LOAD_PATH << $MODULE_PATH
#载入脚本目录
$LOAD_PATH << $SCRIPT_PATH
#载入web目录
$LOAD_PATH << $HTTP_ROOT
