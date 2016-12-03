#!/usr/bin/env ruby

require 'sinatra'
require 'pry' unless ENV["RACK_ENV"] == "production"
require 'json'
require 'carrier-pigeon'

post "/:canal" do
hash=JSON.parse(request.env["rack.request.form_vars"])
#msj=hash["attachments"].first["text"].split("\n").first
msj=hash["text"].gsub(/<[^|]+\|/,"").gsub(">","")
#user=hash["text"].split('u/').last.split('|').first
thread=hash["text"].split('<').last.split('|').first
Thread.new do
  CarrierPigeon.send(
    uri: "irc://starhawk@irc.pirateirc.net:6697/:#{canal}",
    message: "#{msj} en #{thread}", 
    ssl: true,
    join: true,
  )
end
#binding.pry
end

