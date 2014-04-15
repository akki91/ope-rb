require 'spec_helper'
require 'ope'

describe OPE do
  
  Key = ([0] * 16).pack('C*')
  
  it "should produce deterministic output" do
    
    cipher = OPE::Cipher.new(Key)

    100.times do
      num = (rand * 20_000).floor
      
      a = cipher.encrypt(num)
      b = cipher.encrypt(num)
      puts "#{num},#{a}"
      a.should eql b
    end

  end

  it "should maintain proper order" do
    
    cipher = OPE::Cipher.new(Key)
    
    plaintexts = []
    encrypted = []
    
    100.times do
      num = (rand * 100_000).floor
      plaintexts << num
      encrypted << cipher.encrypt(num)
    end
    
    while !plaintexts.empty?
      
      max_dec_pos = plaintexts.index(plaintexts.max)
      max_enc_pos = plaintexts.index(plaintexts.max)
      
      max_dec_pos.should eql max_enc_pos
      
      plaintexts.delete_at(max_dec_pos)
      encrypted.delete_at(max_enc_pos)
      
    end
      
  end

end