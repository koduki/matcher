# -*- encoding: utf-8 -*-
require 'rexml/document'
require 'open-uri'

class MA
  def initialize
     path = File.join(File.dirname(__FILE__), "..", "config", "yahooapis.yml") 
     config = YAML::load(File.open(path))
     @app_id = config['app_id']
  end

  def split(text)
    uri = "http://jlp.yahooapis.jp/MAService/V1/parse"
    result = Array.new()
    body = open("#{uri}?appid=#{@app_id}&results=ma&sentence="+URI.encode("#{text}"))
    doc = REXML::Document.new(body).elements['ResultSet/ma_result/word_list/']
    doc.elements.each('word') do |item|
      word = Hash.new()
      item.elements.each do |property|
        word["#{property.name}"] = property.text
      end
      result << word
    end
    result
  end
end
