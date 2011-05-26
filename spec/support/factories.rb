require 'ostruct'

Factory.sequence :uid do |i| 
  i 
end

Factory.define :user do |u|
  u.uid       { Factory.next :uid }
  u.provider  'github'
end
