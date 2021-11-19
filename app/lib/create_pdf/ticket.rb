class CreatePdf::Ticket
  
  include Prawn::View
  require 'prawn/table'
  require "open-uri"

  def initialize(sale,user)
    @sale = sale
    @user = user
    @products = []
    ticket
  end

  def ticket
    head = "#{Rails.root}/public/images/sales/head.jpeg"
    image head, :at => [75,760], :width => 400
    image open(@user['gym']['logo']), position: :center, :width => 60, :height => 60, :border => 50

    text_box @user['gym']['name'], :at => [0,650], :size => 20, :styles => [:bold, :italic], :align => :center

    text_box "Sale Number", :at => [150,600], :size => 14, :styles => [:bold, :italic], :align => :left
    text_box @sale['id'].to_s, :at => [175,580], :size => 12, :styles => [:bold, :italic]

    text_box "Sale Day", :at => [350,600], :size => 14, :styles => [:bold, :italic]
    text_box DateTime.parse(@sale['created_at']).strftime('%d-%m-%Y %H:%M'), :at => [330,580], :size => 12, :styles => [:bold, :italic]

    text_box "User", :at => [150,540], :size => 14, :styles => [:bold, :italic], :align => :left
    text_box @sale['user']['email'], :at => [150,520], :size => 12, :styles => [:bold, :italic]

    text_box "Client", :at => [350,540], :size => 14, :styles => [:bold, :italic]
    text_box "#{@sale['client'] ? @sale['client']['display_name'] : 'Sale EXternal'}", :at => [340,520], :size => 12, :styles => [:bold, :italic]

    @products << ['Name','Barcode','Price']

    @sale['products'].each do |product|
      product = JSON.parse(product)
      @products << [product['name'],product['barcode'],product['amount']]
    end

    move_down 200

    table @products,:position => :center,:cell_style => { size: 8 }, width: 300
    
    text_box "Total: #{@sale['total']}", :at => [350,280], :size => 12, :styles => [:bold, :italic]
    bottom = "#{Rails.root}/public/images/sales/bottom.jpeg"
    image bottom, :at => [75,250], :width => 400
  end
end