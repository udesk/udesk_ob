Gem::Specification.new do |s|
  files = Dir['lib/udesk_ob/*']
  files << 'lib/udesk_ob.rb'

  s.name        = 'udesk_ob'
  s.version     = '0.0.1'
  s.date        = '2019-03-07'
  s.summary     = 'Udesk Observer, watching you anytime'
  s.description = 'Udesk Monitor client'
  s.authors     = ['Zhang Lei']
  s.email       = 'zhangl@udesk.cn'
  s.homepage    = 'https://www.udesk.cn'
  s.license     = 'Nonstandard'
  s.files       = files
  s.add_dependency 'redis', '~> 3.1'
end
