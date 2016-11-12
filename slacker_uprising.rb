#!/usr/bin/env ruby

require 'sinatra'
require 'pry'
require 'json'
require 'carrier-pigeon'

post "/" do
hash=JSON.parse(request.env["rack.request.form_vars"])
msj=hash["attachments"].first["text"]
user=hash["text"].split('u/').last.split('|').first
thread=hash["text"].split('<').last.split('|').first
Thread.new do
  CarrierPigeon.send(
    uri: "irc://starhawk@irc.pirateirc.net:6697/#ppar",
    message: "#{user} dijo #{msj} en #{thread}", 
    ssl: true,
    join: true,
  )
end
#binding.pry
end

