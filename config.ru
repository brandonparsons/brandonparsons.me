require './app'
require 'rack/rewrite'

# rewrite %r{/features(.*)}, '/facial_features$1'
# r301 %r{.*}, 'http://mynewdomain.com$&', :if => Proc.new {|rack_env| rack_env['SERVER_NAME'] != 'mynewdomain.com' }
# r301 %r{/old-path(\?.*)}, '/new-path$1'
# r301 %r{.*}, 'http://canonical-domain.com$&', :if => Proc.new { |rack_env| rack_env['SERVER_NAME'] != 'canonical-domain.com' }

use Rack::Rewrite do

  ###########
  # GENERAL #
  ###########

  # Redirect all http traffic to https
  r302 %r{.*}, Proc.new {|path, rack_env| "https://#{rack_env['SERVER_NAME']}$&" }, scheme: 'http'

  # Redirect https://www.brandonparsons.me to https://brandonparsons.me
  r302 /.*/,  Proc.new {|path, rack_env| "https://brandonparsons.me#{path}" }, host: 'www.brandonparsons.me'

  ############
  # OLD BLOG #
  ############

  # Rewrite old blog posts
  # Of form: http://brandonparsons.me/2013/installing-gems-in-a-new-chef-system-ruby/
  # To form: https://blog.brandonparsons.me/2013-installing-gems-in-a-new-chef-system-ruby/
  r302 %r{/(\d{4})/(.+)/}, "https://blog.brandonparsons.me/$1-$2", host: 'brandonparsons.me'


  #####################
  # RETIREMENTPLAN.IO #
  #####################

  # Rewrite old blog posts
  # Of form: https://www.retirementplan.io/blog/2014-09-22-management-expense-ratios/
  # To form: http://blog.brandonparsons.me/2014-management-expense-ratios/
  r302 %r{/blog/(\d{4})-(\d{2})-(\d{2})-(.+)/}, "https://blog.brandonparsons.me/$1-$4", host: 'www.retirementplan.io'

  # Rewrite everything else to the project page
  r302 %r{.*}, "https://blog.brandonparsons.me/projects/", host: 'www.retirementplan.io'

end

run SinatraApp
