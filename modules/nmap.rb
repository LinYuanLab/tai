#-*- coding:utf-8 -*-

require 'nmap/program'
require 'nmap/xml'



Nmap::Program.scan do |nmap|
	nmap.syn_scan = true
	nmap.service_scan = true
	nmap.os_fingerprint = true
	nmap.xml = 'd:\scan.xml'
	nmap.verbose = true
	nmap.ports = [22,80,3389,8080]
	nmap.targets = "139.139.139.139"
end


Nmap::XML.new('d:\scan.xml') do |xml|
  xml.each_host do |host|
    puts "[#{host.ip}]"
    host.each_port do |port|
      puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
    end
  end
end
