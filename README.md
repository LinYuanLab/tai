#test

###目录说明:

framework			程序运行框架

framework/database	程序数据库目录

framework/logs		日志文件目录

modules				常用模块的封装

scripts				扫描脚本目录


###项目日志

2016-01-21:

启动项目

2016-01-22

增加Gemfile

使用icmp4em包实现了初期的主机存活性检测

对于检测中存在的误报，暂时不予考虑。

初期实现接口即可。

后期可以考虑使用nmap作为主机存活性和端口检测引擎。

2016-01-25

开始写端口检测模块，开启85个线程探测65535个主机端口，使用socket连接并返回数据。

2016-01-26

写到端口信息探测和指纹识别模块，不知道该怎么写了，很难啊。

2016-01-27

暂时什么也没写，在忙别的。晚上有空先测试一下socket通信。

###项目笔记

模块

1.界面

2.扫描进程调度模块

3.分布式服务器管理模块（C/S模式）

4.漏洞扫描模块

5.爬虫模块

6.数据库模块

任务的生命周期

创建->运行<->挂起->结束
        |
      结束

C create

R run

P pause

D destroy

任务在数据库中的形态

task_id

task_name

task_attribute

task_type

task_target

task_payload

task_status

task_

分布式扫描：
