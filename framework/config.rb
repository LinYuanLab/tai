#!/bin/ruby
#-*- coding:utf-8 -*-

#定义程序全局配置
$WORK_PATH		= File.dirname(__FILE__) 				#程序运行目录
$LOGS_PATH		= "#{File.dirname(__FILE__)}/logs"		#日志文件目录
$PROC_PATH		= "#{File.dirname(__FILE__)}/proc"		#扫描进程目录
$RULE_PATH		= "#{File.dirname(__FILE__)}/rules"		#规则文件目录
$MODULE_PATH	= "#{File.dirname(__FILE__)}/modules"	#模块文件目录
$SCRIPT_PATH	= "#{File.dirname(__FILE__)}/scripts"	#脚本文件目录
$DATABASE_PATH	= "#{File.dirname(__FILE__)}/database"	#数据库文件目录

$TASK_THREAD    = 15    #同时扫描的目标线程数
$SCAN_THREAD    = 10    #单个目标同时开启的线程数

=begin
puts "*"*32
puts "[   配置   ]"
puts "$WORK_PATH\t#{$WORK_PATH}"
puts "$LOGS_PATH\t#{$LOGS_PATH}"
puts "$PROC_PATH\t#{$PROC_PATH}"
puts "$RULE_PATH\t#{$RULE_PATH}"
puts "$MODULE_PATH\t#{$MODULE_PATH}"
puts "$SCRIPT_PATH\t#{$SCRIPT_PATH}"
puts "$DATABASE_PATH\t#{$DATABASE_PATH}"
puts "*"*32
=end

#载入工作区间
$LOAD_PATH << $WORK_PATH
#载入模块目录
$LOAD_PATH << $MODULE_PATH
#载入脚本目录
$LOAD_PATH << $SCRIPT_PATH
